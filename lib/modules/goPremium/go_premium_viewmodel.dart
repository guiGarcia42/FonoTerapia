import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:fono_terapia/data/auth_repository.dart';
import 'package:fono_terapia/data/user_data_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoPremiumViewModel extends ChangeNotifier {
  final AuthRepository authRepository;
  final UserDataStorage userDataStorage;
  final InAppPurchase iap;
  List<ProductDetails> availableProducts = [];

  bool isPremium = false;

  GoPremiumViewModel({
    required this.authRepository,
    required this.userDataStorage,
    required this.iap,
  }) {
    _fetchAvailableSubscriptions(); // Fetch products without initializing the listener again
    _initializePurchaseListener(); // Hook into the global purchase listener
  }

  // Fetch available subscriptions from the store
  Future<void> _fetchAvailableSubscriptions() async {
    const Set<String> _kIds = <String>{'subscription_monthly'}; // Your subscription product ID here
    final ProductDetailsResponse response = await iap.queryProductDetails(_kIds);

    if (response.notFoundIDs.isNotEmpty) {
      print("Subscription product not found: ${response.notFoundIDs}");
    }

    availableProducts = response.productDetails;
    notifyListeners();
  }

  // Start the subscription purchase process
  void startSubscriptionPurchase() {
    if (availableProducts.isNotEmpty) {
      final ProductDetails product = availableProducts.first; // Assuming only one product
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
      iap.buyNonConsumable(purchaseParam: purchaseParam);
    } else {
      print("No products available for purchase");
    }
  }

  // Access and handle the global listener
  void _initializePurchaseListener() {
    final Stream<List<PurchaseDetails>> purchaseUpdated = iap.purchaseStream;

    print('Attaching local listener to purchaseStream...');
    purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      print('Purchase update received, length: ${purchaseDetailsList.length}');
      for (var purchaseDetails in purchaseDetailsList) {
        handlePurchaseUpdate(purchaseDetails);
      }
    }, onError: (error) {
      print("Error in purchase stream: $error");
    });
  }

  // Confirm the purchase by completing it
  Future<void> confirmPurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.pendingCompletePurchase) {
      try {
        await iap.completePurchase(purchaseDetails);
        print("Purchase completed: ${purchaseDetails.productID}");
      } catch (e) {
        print("Error completing purchase: $e");
      }
    }
  }

  // Handle purchase updates that will come from the global listener
  Future<void> handlePurchaseUpdate(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored) {
      // Verify and deliver the subscription
      await _verifyAndDeliverSubscription(purchaseDetails);
    }

    // Confirm the purchase after it's processed
    await confirmPurchase(purchaseDetails);
  }

  // Verify and deliver the subscription to the user
  Future<void> _verifyAndDeliverSubscription(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.productID == 'subscription_monthly') {
      print("Validating subscription for product: ${purchaseDetails.productID}");

      var user = await authRepository.currentUser;
      if (user != null) {
        var userData = await userDataStorage.loadUserData();
        if (userData != null) {
          userData.isPremium = true;
          await userDataStorage.saveUserData(userData);
        }

        // Update Firestore
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).update({
          'isPremium': true,
        });

        // Mark user as premium
        isPremium = true;
        notifyListeners(); // Notify the UI about the premium status
      }
    } else {
      print("Unknown product ID: ${purchaseDetails.productID}");
    }
  }
}