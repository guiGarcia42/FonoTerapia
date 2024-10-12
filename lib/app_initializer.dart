import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fono_terapia/data/auth_repository.dart';
import 'package:fono_terapia/data/service/user_service.dart';
import 'package:fono_terapia/data/user_data_storage.dart';
import 'package:fono_terapia/database/app_database.dart';
import 'package:fono_terapia/database/dao/category_dao.dart';
import 'package:fono_terapia/database/firebase_database.dart';
import 'package:fono_terapia/firebase_options.dart';
import 'package:fono_terapia/shared/utils/responsive_size.dart';
import 'package:sqflite/sqflite.dart';

class AppInitializer {
  static late Database database;
  static late ResponsiveSize responsiveSize;
  static late AuthRepository authRepository;
  static late UserService userService;
  static late UserDataStorage userDataStorage;
  static late FirebaseDatabase firebaseDatabase;
  static late CategoryDao categoryDao;

  static Future<void> initializeApp(BuildContext context) async {
    // Initialize Firebase
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    // Initialize database
    database = await openOrInitializeDatabase();

    // Initialize responsiveSize
    responsiveSize = ResponsiveSize(mediaQueryData: MediaQuery.of(context));

    // Initialize Auth and UserService
    authRepository = AuthRepository();

    userDataStorage = UserDataStorage();

    userService = UserService(userDataStorage);

    firebaseDatabase = FirebaseDatabase();

    categoryDao = CategoryDao();
  }
}