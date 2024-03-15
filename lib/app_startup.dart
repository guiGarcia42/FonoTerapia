// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:fono_terapia/database/app_database.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_assets.dart';
import 'package:fono_terapia/shared/utils/responsive_size.dart';
import 'package:sqflite/sqflite.dart';

late Database database;
late ResponsiveSize responsiveSize;

class AppStartup extends StatefulWidget {
  const AppStartup({super.key});

  @override
  State<AppStartup> createState() => _AppStartupState();
}

class _AppStartupState extends State<AppStartup> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  _initApp() async {
    database = await openOrInitializeDatabase();
    await Future.delayed(Duration(seconds: 3));

    responsiveSize =
        ResponsiveSize(mediaQueryData: MediaQuery.of(context).size);

    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Center(child: Image.asset(AppAssets.union)),
          Center(child: Image.asset(AppAssets.logoFull)),
        ],
      ),
    );
  }
}
