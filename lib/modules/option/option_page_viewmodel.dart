import 'package:flutter/material.dart';
import 'package:fono_terapia/database/app_database.dart';
import 'package:fono_terapia/database/dao/sub_category_dao.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';

class OptionPageViewModel extends ChangeNotifier {
  final SubCategoryDao subCategoryDao;

  OptionPageViewModel() : subCategoryDao = SubCategoryDao();

  Future<List<SubCategory>> findAllSubCategories(int categoryId) async {
    final db = await openOrInitializeDatabase(); // Initialize or retrieve the database
    return subCategoryDao.findAllSubCategories(db, categoryId);
  }
}