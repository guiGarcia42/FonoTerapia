import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fono_terapia/data/user_data_storage.dart';
import 'package:fono_terapia/shared/model/user_data.dart';

class UserService {
  final UserDataStorage userDataStorage;

  UserService(this.userDataStorage);

  Future<bool> isNewUser(User user) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();

    return !userDoc.exists;
  }

  Future<String> checkSubscriptionValidity(User user) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();

    // Load local user data
    UserData? localUserData = await userDataStorage.loadUserData();
    bool isPremiumLocal = localUserData?.isPremium ?? false;

    bool isPremiumFirestore = userDoc['isPremium'];

    // Validate subscription with payment provider (pseudo-code, replace with real implementation)
    bool isSubscriptionValid = await _checkSubscriptionWithProvider(user);

    // If the subscription status has changed, update it both locally and in Firestore
    if (isSubscriptionValid != isPremiumLocal || isSubscriptionValid != isPremiumFirestore) {
      await userDataStorage.updatePremiumStatus(isSubscriptionValid);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .update({'isPremium': isSubscriptionValid});
    }

    return isSubscriptionValid ? "/menu" : "/goPremium";
  }

  Future<bool> _checkSubscriptionWithProvider(User user) async {
    // Implement the logic to check the user's subscription status with your payment provider
    return true; // Replace with actual subscription validation logic
  }
}