import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fono_terapia/data/auth_repository.dart';
import 'package:fono_terapia/data/user_data_storage.dart';
import 'package:fono_terapia/database/firebase_database.dart';
import 'package:fono_terapia/shared/model/user_data.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthRepository authRepository;
  final UserDataStorage userDataStorage;
  final FirebaseDatabase firebaseDatabase;

  final nameController = TextEditingController();

  RegisterViewModel({
    required this.authRepository,
    required this.userDataStorage,
    required this.firebaseDatabase,
  }) {
    _init();
  }

  void _init() {
    User? user = authRepository.currentUser;
    if (user != null) {
      nameController.text = user.displayName ?? "";
    }
  }

  // Save user data to SharedPreferences
  Future<void> saveUserLocally() async {
    UserData userData = UserData(
      name: nameController.text,
      isPremium: false, // or set according to the app's logic
    );

    await userDataStorage.saveUserData(userData);
  }

  Future<void> registerUserInDatabase() async {
    Map<String, dynamic> userInfoMap = {
      "id": authRepository.currentUser!.uid,
      "name": nameController.text,
      "email": authRepository.currentUser!.email,
      "isPremium": false,
    };

    await firebaseDatabase.addUser(
      authRepository.currentUser!.uid,
      userInfoMap,
    );
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    notifyListeners();
  }
}