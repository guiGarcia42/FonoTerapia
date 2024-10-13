import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fono_terapia/data/user_data_storage.dart';
import 'package:fono_terapia/shared/model/user_data.dart';

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

// Function to check subscription when user is already logged in
  Future<String> checkSubscriptionValidity(User user) async {
    print('Checking subscription validity for user: ${user.uid}');

    // Retrieve Firestore subscription status
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();

    print('Loaded user document from Firestore');

    // Load local user data from SharedPreferences
    UserData? localUserData = await userDataStorage.loadUserData();

    if (localUserData == null) {
      // If no local data exists, fetch from Firestore
      print('No UserData found in SharedPreferences, fetching from Firestore...');
      if (userDoc.exists) {
        localUserData = UserData(
          name: userDoc['name'],
          isPremium: userDoc['isPremium'],
        );
        // Save fetched user data locally
        await userDataStorage.saveUserData(localUserData);
      } else {
        print('User data not found in Firestore.');
      }
    }

    bool isPremiumLocal = localUserData?.isPremium ?? false;
    print('Local premium status: $isPremiumLocal');

    // Get Firestore subscription status
    bool isPremiumFirestore = userDoc['isPremium'] ?? false;
    print('Firestore premium status: $isPremiumFirestore');

    // Check if subscription has been validated
    bool isSubscriptionValid = isPremiumFirestore || isPremiumLocal;

    // If subscription status differs between sources, update accordingly
    if (isSubscriptionValid != isPremiumLocal) {
      print('Updating local subscription status...');
      await userDataStorage.updatePremiumStatus(isSubscriptionValid);
    }

    // Navigate based on the subscription status
    String route = isSubscriptionValid ? "/menu" : "/goPremium";
    print('Navigating to: $route');
    return route;
  }
}