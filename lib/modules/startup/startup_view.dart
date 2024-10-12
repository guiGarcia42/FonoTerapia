import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fono_terapia/app_initializer.dart';
import 'package:fono_terapia/data/auth_repository.dart';
import 'package:fono_terapia/data/service/user_service.dart';
import 'package:fono_terapia/data/user_data_storage.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_assets.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/user_data.dart';
import 'package:fono_terapia/shared/utils/responsive_size.dart';
import 'package:fono_terapia/shared/widgets/sign_in_button.dart';
import 'package:fono_terapia/shared/widgets/my_text.dart';

class StartupView extends StatelessWidget {
  const StartupView({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the global instances of authRepository and userService
    final AuthRepository authRepo = AppInitializer.authRepository;
    final UserService userService = AppInitializer.userService;
    final UserDataStorage userDataStorage = AppInitializer.userDataStorage;
    final responsiveSize = AppInitializer.responsiveSize;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: responsiveSize.width,
            height: responsiveSize.height * 0.4,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [AppColors.lightOrange, AppColors.darkOrange],
                center: Alignment.center,
                radius: 0.7,
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: responsiveSize.scaleSize(100),
                child: SizedBox(
                  height: responsiveSize.scaleSize(500),
                  child: Image.asset(
                    AppAssets.person,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: responsiveSize.scaleSize(50),
                child: SizedBox(
                  width: responsiveSize.scaleSize(350),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: responsiveSize.scaleSize(125),
                        child: Image.asset(
                          AppAssets.logoMini,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: responsiveSize.scaleSize(30),
                        ),
                        child: MyText(
                          "Atividades Terapêuticas para a Afasia",
                          textAlign: TextAlign.center,
                          style: TextStyles.title.copyWith(
                            fontSize: responsiveSize
                                .scaleSize(TextStyles.title.fontSize!),
                            color: AppColors.darkGray,
                          ),
                        ),
                      ),
                      _googleSignInButton(
                        context,
                        userDataStorage,
                        userService,
                        authRepo,
                        responsiveSize,
                      ),
                      if (Platform.isIOS)
                        _appleSignInButton(
                          context,
                          userDataStorage,
                          userService,
                          authRepo,
                          responsiveSize,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _googleSignInButton(
    BuildContext context,
    UserDataStorage userDataStorage,
    UserService userService,
    AuthRepository authRepo,
    ResponsiveSize responsiveSize,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: responsiveSize.scaleSize(10),
      ),
      child: SignInButton(
        image: AppAssets.google,
        name: "Google",
        onPressed: () async {
          try {
            User? user = await authRepo.signInWithGoogle();

            if (user != null) {
              bool isNewUser = await userService.isNewUser(user);

              if (isNewUser) {
                Navigator.pushReplacementNamed(context, "/register");
              } else {
                // Fetch user data from Firestore
                DocumentSnapshot userDoc = await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(user.uid)
                    .get();

                if (userDoc.exists) {
                  // Create UserData object from Firestore document
                  UserData userData = UserData(
                    name: userDoc['name'],
                    isPremium: userDoc['isPremium'],
                  );

                  // Save user data locally
                  await userDataStorage.saveUserData(userData);

                  // Check subscription validity and navigate
                  String navigationRoute =
                      await userService.checkSubscriptionValidity(user);
                  Navigator.pushReplacementNamed(context, navigationRoute);
                } else {
                  // Handle the case where user data does not exist in Firestore
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("User data not found in Firestore."),
                    ),
                  );
                }
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed to sign in with Google."),
                ),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("An error occurred during Google Sign-In."),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _appleSignInButton(
    BuildContext context,
    UserDataStorage userDataStorage,
    UserService userService,
    AuthRepository authRepo,
    ResponsiveSize responsiveSize,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: responsiveSize.scaleSize(10),
      ),
      child: SignInButton(
        image: AppAssets.apple,
        name: "Apple",
        onPressed: () async {
          try {
            User? user = await authRepo.signInWithApple();

            if (user != null) {
              bool isNewUser = await userService.isNewUser(user);

              if (isNewUser) {
                Navigator.pushReplacementNamed(context, "/register");
              } else {
                // Fetch user data from Firestore
                DocumentSnapshot userDoc = await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(user.uid)
                    .get();

                if (userDoc.exists) {
                  // Create UserData object from Firestore document
                  UserData userData = UserData(
                    name: userDoc['name'],
                    isPremium: userDoc['isPremium'],
                  );

                  // Save user data locally
                  await userDataStorage.saveUserData(userData);

                  // Check subscription validity and navigate
                  String navigationRoute =
                      await userService.checkSubscriptionValidity(user);
                  Navigator.pushReplacementNamed(context, navigationRoute);
                } else {
                  // Handle the case where user data does not exist in Firestore
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("User data not found in Firestore."),
                    ),
                  );
                }
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed to sign in with Apple."),
                ),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("An error occurred during Apple Sign-In."),
              ),
            );
          }
        },
      ),
    );
  }
}
