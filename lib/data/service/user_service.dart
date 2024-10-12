import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fono_terapia/data/user_data_storage.dart';
import 'package:fono_terapia/shared/model/user_data.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class UserService {
  final UserDataStorage userDataStorage;

  UserService(this.userDataStorage);

  Future<bool> isNewUser(User user) async {
    print('Checking if user is new...');
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();

    bool isNew = !userDoc.exists;
    print('User is ${isNew ? "new" : "existing"}');
    return isNew;
  }

  Future<String> checkSubscriptionValidity(User user) async {
    print('Checking subscription validity for user: ${user.uid}');

    // Retrieve Firestore subscription status
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();

    print('Loaded user document from Firestore');

    // Load local user data
    UserData? localUserData = await userDataStorage.loadUserData();
    bool isPremiumLocal = localUserData?.isPremium ?? false;
    print('Local premium status: $isPremiumLocal');

    // Get Firestore subscription status
    bool isPremiumFirestore = userDoc['isPremium'] ?? false;
    print('Firestore premium status: $isPremiumFirestore');

    // Validate subscription with the payment provider (App Store/Play Store)
    bool isSubscriptionValid = await _checkSubscriptionWithProvider();
    print('Subscription status from provider: $isSubscriptionValid');

    // If subscription status differs between sources, update accordingly
    if (isSubscriptionValid != isPremiumLocal || isSubscriptionValid != isPremiumFirestore) {
      print('Updating subscription status locally and in Firestore...');
      await userDataStorage.updatePremiumStatus(isSubscriptionValid);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .update({'isPremium': isSubscriptionValid});
    } else {
      print('No update needed for subscription status');
    }

    // Navigate based on the subscription status
    String route = isSubscriptionValid ? "/menu" : "/goPremium";
    print('Navigating to: $route');
    return route;
  }

  Future<bool> _checkSubscriptionWithProvider() async {
    print('Checking subscription with provider...');

    final InAppPurchase inAppPurchase = InAppPurchase.instance;

    print("Restoring previous purchases...");
    bool available = await inAppPurchase.isAvailable();
    print("Store availability: $available");

    if (!available) {
      print("Store is not available");
      return false;
    }

    try {
      await inAppPurchase.restorePurchases();
      print("Purchases restored successfully");
    } catch (e) {
      print("Error restoring purchases: $e");
      return false; // Return false if there's an error in restoring purchases
    }

    // Listen for purchase updates and validate subscription status
    final Completer<bool> subscriptionCompleter = Completer<bool>();
    final Stream<List<PurchaseDetails>> purchaseUpdated = inAppPurchase.purchaseStream;

    final subscription = purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) async {
      print('Purchase update received, length: ${purchaseDetailsList.length}');

      if (purchaseDetailsList.isEmpty) {
        print("No purchase details received.");
        // Check local subscription status before timing out
        UserData? localUserData = await userDataStorage.loadUserData();
        if (localUserData?.isPremium ?? false) {
          print("Using local subscription status as fallback: isPremium = true");
          if (!subscriptionCompleter.isCompleted) {
            subscriptionCompleter.complete(true);
          }
        } else {
          print("No active subscription found in purchases or local data.");
          if (!subscriptionCompleter.isCompleted) {
            subscriptionCompleter.complete(false);
          }
        }
      } else {
        bool subscriptionActive = false;

        for (var purchaseDetails in purchaseDetailsList) {
          print('Processing purchase details: ${purchaseDetails.productID}, with Status: ${purchaseDetails.status}');

          if (purchaseDetails.productID == 'subscription_monthly' &&
              (purchaseDetails.status == PurchaseStatus.purchased ||
                  purchaseDetails.status == PurchaseStatus.restored)) {
            print('Subscription is active for product: ${purchaseDetails.productID}');
            subscriptionActive = true;
            break;
          } else {
            print('Purchase status: ${purchaseDetails.status}, productID: ${purchaseDetails.productID}');
          }
        }

        if (subscriptionActive) {
          print('Completing subscription as active');
          if (!subscriptionCompleter.isCompleted) {
            subscriptionCompleter.complete(true);
          }
        } else {
          print("No active subscription found");
          if (!subscriptionCompleter.isCompleted) {
            subscriptionCompleter.complete(false);
          }
        }
      }
    });

    // Wait for subscription validation result
    return subscriptionCompleter.future.timeout(Duration(seconds: 30), onTimeout: () {
      print("Subscription check timed out");
      if (!subscriptionCompleter.isCompleted) {
        subscriptionCompleter.complete(false);
      }
      subscription.cancel();
      return false;
    });
  }
}