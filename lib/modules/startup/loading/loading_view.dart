import 'package:flutter/material.dart';
import 'package:fono_terapia/app_initializer.dart';
import 'package:fono_terapia/shared/assets/app_assets.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'loading_viewmodel.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  late Future<void> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = _initializeApp();
  }

  Future<void> _initializeApp() async {
    await AppInitializer.initializeApp(context);

    final loadingViewModel = LoadingViewModel(
      authRepository: AppInitializer.authRepository,
      userService: AppInitializer.userService,
    );

    // After initializing, validate subscription and navigate
    await loadingViewModel.validateAndNavigate(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FutureBuilder<void>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return loadingImages();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error initializing the app: ${snapshot.error}'),
            );
          } else {
            return loadingImages(); // Show loading state
          }
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