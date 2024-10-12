import 'package:flutter/material.dart';
import 'package:fono_terapia/app_initializer.dart';
import 'package:fono_terapia/data/auth_repository.dart';
import 'package:fono_terapia/data/user_data_storage.dart';
import 'package:fono_terapia/database/dao/category_dao.dart';
import 'package:fono_terapia/shared/model/category.dart';
import 'package:fono_terapia/shared/model/user_data.dart';

class MenuViewModel extends ChangeNotifier {
  final CategoryDao categoryDao;
  final AuthRepository authRepository;
  final UserDataStorage userDataStorage;
  UserData? userData;
  List<Category> categories = [];

  MenuViewModel({
    required this.categoryDao,
    required this.authRepository,
  }) : userDataStorage = UserDataStorage() {
    _init();
  }

  Future<void> _init() async {
    await loadUserData();
    await loadCategories();
  }

  Future<void> loadUserData() async {
    userData = await userDataStorage.loadUserData();
    notifyListeners();
  }

  Future<void> loadCategories() async {
    categories = await categoryDao.findAllCategories(AppInitializer.database); // Use global database
    notifyListeners();
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    await userDataStorage.clearUserData(); // Clear user data when signing out
    notifyListeners();
  }
}