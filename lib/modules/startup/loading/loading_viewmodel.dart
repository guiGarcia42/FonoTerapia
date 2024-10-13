import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fono_terapia/app_initializer.dart';
import 'package:fono_terapia/data/auth_repository.dart';
import 'package:fono_terapia/data/service/user_service.dart';

class LoadingViewModel with ChangeNotifier {
  final AuthRepository authRepository;
  final UserService userService;

  LoadingViewModel({
    required this.authRepository,
    required this.userService,
  });

  // Validate and navigate based on user subscription status
  Future<void> validateAndNavigate(BuildContext context) async {
    User? currentUser = authRepository.currentUser;

    if (currentUser != null) {
      // Initialize InAppPurchase services after login
      await AppInitializer.initializePurchaseServices();

      // Check the user's subscription status and navigate accordingly
      String navigationRoute = await userService.checkSubscriptionValidity(currentUser);
      Navigator.pushReplacementNamed(context, navigationRoute);
    } else {
      // Navigate to startup if the user is not logged in
      Navigator.pushReplacementNamed(context, "/startup");
    }
  }
}