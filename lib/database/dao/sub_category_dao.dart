import 'package:fono_terapia/database/dao/category_dao.dart';

class SubCategoryDao {
  static const _tableName = 'sub_categories';
  static const _id = 'id';
  static const _name = 'name';
  static const _imagePath = 'image_path';
  static const _categoryId = 'category_id';
  static const _categoryTableName = CategoryDao.tableName;

  static const tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_name TEXT NOT NULL, '
      '$_imagePath TEXT NOT NULL, '
      '$_categoryId INTEGER NOT NULL, '
      'FOREIGN KEY ($_categoryId) REFERENCES $_categoryTableName($_id));';
}