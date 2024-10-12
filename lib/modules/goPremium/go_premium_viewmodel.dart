import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:fono_terapia/data/auth_repository.dart';
import 'package:fono_terapia/data/user_data_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoPremiumViewModel extends ChangeNotifier {
  final AuthRepository authRepository;
  final UserDataStorage userDataStorage;
  final InAppPurchase _iap = InAppPurchase.instance;
  List<ProductDetails> availableProducts = [];

  // Add isPremium flag
  bool isPremium = false;

  GoPremiumViewModel({
    required this.authRepository,
    required this.userDataStorage,
  }) {
    _initialize();
  }

  // Initialize and fetch available products
  Future<void> _initialize() async {
    _initializePurchaseListener();
    await _fetchAvailableSubscriptions();
  }

  // Initialize the purchase listener
  void _initializePurchaseListener() {
    print('Initializing purchase listener');
    final Stream<List<PurchaseDetails>> purchaseUpdated = _iap.purchaseStream;

    print('Attaching listener to purchaseStream...');
    purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      print('Purchase update received, length: ${purchaseDetailsList.length}');
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onError: (error) {
      print("Error in purchase stream: $error");
    });
  }

  // Fetch available subscriptions from the store
  Future<void> _fetchAvailableSubscriptions() async {
    const Set<String> _kIds = <String>{'subscription_monthly'}; // Your subscription product ID here
    final ProductDetailsResponse response = await _iap.queryProductDetails(_kIds);

    if (response.notFoundIDs.isNotEmpty) {
      print("Subscription product not found: ${response.notFoundIDs}");
    }

    availableProducts = response.productDetails;
    notifyListeners();
  }

  // Handle purchase updates
  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored) {
        bool valid = await _verifySubscription(purchaseDetails);
        if (valid) {
          await _deliverSubscription(purchaseDetails);
        }
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await _iap.completePurchase(purchaseDetails);
      }
    }
  }

  // Verify the subscription (you could do this locally or with a server)
  Future<bool> _verifySubscription(PurchaseDetails purchaseDetails) async {
    // Check if the product ID is correct
    if (purchaseDetails.productID != 'subscription_monthly') {
      print("Invalid product ID");
      return false;
    }

    // Check if the purchase status is either purchased or restored
    if (purchaseDetails.status != PurchaseStatus.purchased &&
        purchaseDetails.status != PurchaseStatus.restored) {
      print("Purchase is not completed or restored");
      return false;
    }

    // Optionally check the transaction date (e.g., for very old purchases)
    DateTime purchaseDate = DateTime.fromMillisecondsSinceEpoch(
        int.parse(purchaseDetails.transactionDate ?? '0'));
    print("Purchase date: $purchaseDate");

    // Assuming no further checks are needed, mark the purchase as valid
    return true;
  }

  // Deliver the subscription to the user by updating Firestore and local storage
  Future<void> _deliverSubscription(PurchaseDetails purchaseDetails) async {
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
  }

  // Start the subscription purchase process
  void startSubscriptionPurchase() {
    if (availableProducts.isNotEmpty) {
      final ProductDetails product = availableProducts.first; // Assuming only one product
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
      _iap.buyNonConsumable(purchaseParam: purchaseParam);
    } else {
      print("No products available for purchase");
    }
  }

  // Sign out logic
  Future<void> signOut() async {
    await authRepository.signOut();
    await userDataStorage.clearUserData(); // Clear user data when signing out
    notifyListeners();
  }
}