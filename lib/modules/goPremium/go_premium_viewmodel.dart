import 'package:flutter/material.dart';
import 'package:fono_terapia/data/auth_repository.dart';
import 'package:fono_terapia/data/user_data_storage.dart';

class GoPremiumViewModel extends ChangeNotifier {
  final AuthRepository authRepository;
  final UserDataStorage userDataStorage;

  GoPremiumViewModel()
      : authRepository = AuthRepository(),
        userDataStorage = UserDataStorage();

  Future<void> signOut() async {
    await authRepository.signOut();
    await userDataStorage.clearUserData(); // Clear user data when signing out
    notifyListeners();
  }
}