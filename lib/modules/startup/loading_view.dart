import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fono_terapia/data/auth_repository.dart';
import 'package:fono_terapia/data/service/user_service.dart';
import 'package:fono_terapia/data/user_data_storage.dart';
import 'package:fono_terapia/database/app_database.dart';
import 'package:fono_terapia/firebase_options.dart';
import 'package:fono_terapia/shared/assets/app_assets.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/utils/responsive_size.dart';
import 'package:sqflite/sqflite.dart';

late Database database;
late ResponsiveSize responsiveSize;

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  late Future _initialization;
  late AuthRepository authRepository; // Instance of AuthRepository
  late UserService userService;

  @override
  void initState() {
    super.initState();
    _initialization = _initApp();
  }

  Future<void> _initApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    database = await openOrInitializeDatabase();
    responsiveSize = ResponsiveSize(mediaQueryData: MediaQuery.of(context));
    authRepository = AuthRepository(); // Initialize the repository

    userService = UserService(UserDataStorage());

    // Validate subscription
    await _validateAndNavigate();
  }

  Future<void> _validateAndNavigate() async {
    User? currentUser = authRepository.currentUser;

    if (currentUser != null) {
      String navigationRoute = await userService.checkSubscriptionValidity(currentUser);

      await Future.delayed(
        Duration(
          seconds: 2,
        ),
      );

      Navigator.pushReplacementNamed(context, navigationRoute);
    } else {

      await Future.delayed(
        Duration(
          seconds: 2,
        ),
      );

      Navigator.pushReplacementNamed(context, "/startup");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return loadingImages(); // This will be replaced by _validateSubscriptionStatus logic
          }
          return loadingImages();
        },
      ),
    );
  }

  Widget loadingImages() {
    return Stack(
      children: [
        Center(child: Image.asset(AppAssets.union)),
        Center(child: Image.asset(AppAssets.logoFull)),
      ],
    );
  }
}
