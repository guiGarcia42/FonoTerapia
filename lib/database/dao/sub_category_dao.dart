import 'package:fono_terapia/database/dao/category_dao.dart';
import 'package:fono_terapia/shared/model/category.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:sqflite/sqflite.dart';

class SubCategoryDao {
  static const tableName = 'sub_categories';
  static const _id = 'id';
  static const _name = 'name';
  static const _imagePath = 'image_path';
  static const _section = 'section';
  static const _categoryId = 'category_id';
  static const _categoryTableName = CategoryDao.tableName;

  static const subCategoryNames = [
    'Ouvir e escolher a imagem',
    'Ouvir e responder sim ou não',
    'Pares Mínimos: Ouvir e escolher a imagem',
    'Sentenças: Ouvir e escolher a imagem',
    'Ouvir e escolher a palavra',
    'Ler e escolher a imagem',
    'Ver e escolher a palavra',
    'Ler e responder sim ou não',
    'Pares Mínimos: Ver e escolher a palavra',
    'Sentenças: Ler e escolher a imagem',
    'Falar o nome da imagem',
    'Sentenças: Descrever a imagem',
    'Repetição de palavras',
    'Repetição de letras',
    'Escrever o nome da imagem',
    'Ouvir e escrever a palavra',
    'Ouvir e escrever a letra',
  ];

  static const imagePathList = [
    'assets/app_assets/sub_categories/1.png',
    'assets/app_assets/sub_categories/2.png',
    'assets/app_assets/sub_categories/3.png',
    'assets/app_assets/sub_categories/4.png',
    'assets/app_assets/sub_categories/5.png',
    'assets/app_assets/sub_categories/6.png',
    'assets/app_assets/sub_categories/7.png',
    'assets/app_assets/sub_categories/8.png',
    'assets/app_assets/sub_categories/9.png',
    'assets/app_assets/sub_categories/10.png',
    'assets/app_assets/sub_categories/11.png',
    'assets/app_assets/sub_categories/12.png',
    'assets/app_assets/sub_categories/13.png',
    'assets/app_assets/sub_categories/14.png',
    'assets/app_assets/sub_categories/15.png',
    'assets/app_assets/sub_categories/16.png',
    'assets/app_assets/sub_categories/17.png',
  ];

  static const sectionList = [
    1,
    4,
    3,
    2,
    1,
    1,
    1,
    4,
    3,
    2,
    1,
    2,
    1,
    5,
    1,
    1,
    5,
  ];

  static const categoryIDs = [
    1,
    1,
    1,
    1,
    1,
    2,
    2,
    2,
    2,
    2,
    3,
    3,
    3,
    3,
    4,
    4,
    4,
  ];

  static String get tableSql {
    return '''CREATE TABLE $tableName(
        $_id INTEGER PRIMARY KEY AUTOINCREMENT,
        $_name TEXT NOT NULL,
        $_imagePath TEXT NOT NULL,
        $_section INTEGER NOT NULL,
        $_categoryId INTEGER NOT NULL,
        FOREIGN KEY ($_categoryId) REFERENCES $_categoryTableName($_id)
        );''';
  }

  static String get tableData {
    if (subCategoryNames.length != sectionList.length ||
        subCategoryNames.length != categoryIDs.length ||
        subCategoryNames.length != imagePathList.length) {
      throw Exception('Arrays têm tamanhos diferentes');
    }

    StringBuffer buffer = StringBuffer();
    buffer.write(
        "INSERT INTO $tableName ($_name, $_imagePath, $_section, $_categoryId) VALUES ");

    for (int i = 0; i < subCategoryNames.length; i++) {
      buffer.write(
          "('${subCategoryNames[i]}', '${imagePathList[i]}', ${sectionList[i]}, ${categoryIDs[i]})");
      if (i < subCategoryNames.length - 1) {
        buffer.write(", ");
      }
    }

    buffer.write(";");
    return buffer.toString();
  }

  Future<SubCategory> findSubCategory(Database db, int subCategoryId) async {
    final List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: '$_id = ?',
      whereArgs: [subCategoryId],
    );

    final Map<String, dynamic> row = result.first;

    return SubCategory.withoutCategory(
        row[_id], row[_name], row[_imagePath], row[_section]);
  }

  Future<List<SubCategory>> findAllSubCategories(Database db, int categoryId) async {
    final List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: '$_categoryId = ?',
      whereArgs: [categoryId],
    );

    return _toList(result, db);
  }

  Future<List<SubCategory>> _toList(List<Map<String, dynamic>> result, Database db) async {
    final List<SubCategory> subCategories = [];

    for (Map<String, dynamic> row in result) {
      final int categoryId = row[_categoryId];
      final Category category = await CategoryDao().findCategory(db, categoryId);
      final SubCategory subCategory = await _fromMap(row, category);
      subCategories.add(subCategory);
    }

    return subCategories;
  }

  Future<SubCategory> _fromMap(Map<String, dynamic> map, Category category) async {
    final subCategoryId = map[_id];

    return SubCategory(
      subCategoryId,
      map[_name],
      map[_imagePath],
      map[_section],
      category,
    );
  }
}