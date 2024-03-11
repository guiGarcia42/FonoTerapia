import 'package:fono_terapia/app_startup.dart';
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
    'Ler e escolher a imagem',
    'Ver a imagem e escolher a palavra',
    'Ler e responder sim ou não',
    'Ouvir e escolher a palavra',
    'Falar o nome da imagem',
    'Sentenças: Descrever imagem',
    'Repetição de palavras',
    'Escrever o nome da imagem',
    'Ouvir e escrever a palavra',
    'Ouvir e escrever a letra',
  ];

  // TO-DO Atualizar lista com o path dos icones da subCategory
  static const imagePathList = [
    'assets/app_images/cafe.jpg',
    'assets/app_images/pao.jpg',
    'assets/app_images/leite.jpg',
    'assets/app_images/carro.jpg',
    'assets/app_images/pato.jpg',
    'assets/app_images/gato.jpg',
    'assets/app_images/cafe.jpg',
    'assets/app_images/pao.jpg',
    'assets/app_images/leite.jpg',
    'assets/app_images/carro.jpg',
    'assets/app_images/pato.jpg',
    'assets/app_images/gato.jpg',
    'assets/app_images/cafe.jpg',
    'assets/app_images/pao.jpg',
  ];

  static const sectionList = [1, 4, 3, 2, 1, 1, 4, 1, 1, 2, 1, 1, 1, 1];

  static const categoryIDs = [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 4];

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

  // static String get tableData {
  //   return "INSERT INTO $_tableName ($_name, $_imagePath, $_categoryId) VALUES "
  //       "('${subCategoryNames[0]}', '${imagePathList[0]}', ${categoryIDs[0]}), "
  //       "('${subCategoryNames[1]}', '${imagePathList[1]}', ${categoryIDs[1]}), "
  //       "('${subCategoryNames[2]}', '${imagePathList[2]}', ${categoryIDs[2]}), "
  //       "('${subCategoryNames[3]}', '${imagePathList[3]}', ${categoryIDs[3]}), "
  //       "('${subCategoryNames[4]}', '${imagePathList[4]}', ${categoryIDs[4]}), "
  //       "('${subCategoryNames[5]}', '${imagePathList[5]}', ${categoryIDs[5]}), "
  //       "('${subCategoryNames[6]}', '${imagePathList[6]}', ${categoryIDs[6]}), "
  //       "('${subCategoryNames[7]}', '${imagePathList[7]}', ${categoryIDs[7]}), "
  //       "('${subCategoryNames[8]}', '${imagePathList[8]}', ${categoryIDs[8]}), "
  //       "('${subCategoryNames[9]}', '${imagePathList[9]}', ${categoryIDs[9]}), "
  //       "('${subCategoryNames[10]}', '${imagePathList[10]}', ${categoryIDs[10]}), "
  //       "('${subCategoryNames[11]}', '${imagePathList[11]}', ${categoryIDs[11]}), "
  //       "('${subCategoryNames[12]}', '${imagePathList[12]}', ${categoryIDs[12]}), "
  //       "('${subCategoryNames[13]}', '${imagePathList[13]}', ${categoryIDs[13]}); ";
  // }

  static String get tableData {
    return "INSERT INTO $tableName ($_name, $_imagePath, $_section, $_categoryId) VALUES "
        "('${subCategoryNames[0]}', '${CategoryDao.imagePathList[0]}', ${sectionList[0]}, ${categoryIDs[0]}), "
        "('${subCategoryNames[1]}', '${CategoryDao.imagePathList[0]}', ${sectionList[1]}, ${categoryIDs[1]}), "
        "('${subCategoryNames[2]}', '${CategoryDao.imagePathList[0]}', ${sectionList[2]}, ${categoryIDs[2]}), "
        "('${subCategoryNames[3]}', '${CategoryDao.imagePathList[0]}', ${sectionList[3]}, ${categoryIDs[3]}), "
        "('${subCategoryNames[4]}', '${CategoryDao.imagePathList[1]}', ${sectionList[4]}, ${categoryIDs[4]}), "
        "('${subCategoryNames[5]}', '${CategoryDao.imagePathList[1]}', ${sectionList[5]}, ${categoryIDs[5]}), "
        "('${subCategoryNames[6]}', '${CategoryDao.imagePathList[1]}', ${sectionList[6]}, ${categoryIDs[6]}), "
        "('${subCategoryNames[7]}', '${CategoryDao.imagePathList[1]}', ${sectionList[7]}, ${categoryIDs[7]}), "
        "('${subCategoryNames[8]}', '${CategoryDao.imagePathList[2]}', ${sectionList[8]}, ${categoryIDs[8]}), "
        "('${subCategoryNames[9]}', '${CategoryDao.imagePathList[2]}', ${sectionList[9]}, ${categoryIDs[9]}), "
        "('${subCategoryNames[10]}', '${CategoryDao.imagePathList[2]}', ${sectionList[10]}, ${categoryIDs[10]}), "
        "('${subCategoryNames[11]}', '${CategoryDao.imagePathList[3]}', ${sectionList[11]}, ${categoryIDs[11]}), "
        "('${subCategoryNames[12]}', '${CategoryDao.imagePathList[3]}', ${sectionList[12]}, ${categoryIDs[12]}), "
        "('${subCategoryNames[13]}', '${CategoryDao.imagePathList[3]}', ${sectionList[13]}, ${categoryIDs[13]}); ";
  }

  Future<SubCategory> findSubCategory(Database db, int subCategoryId) async {
    final List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: '$_id = $subCategoryId',
    );
    final Map<String, dynamic> row = result.first;

    return SubCategory.withoutCategory(
      row[_id],
      row[_name],
      row[_imagePath],
      row[_section]
    );
  }

  Future<List<SubCategory>> findAllSubCategories(
      Database db, int categoryId) async {
    print(categoryId);
    final List<Map<String, dynamic>> result =
        await db.query(tableName, where: '$_categoryId = $categoryId');
    return await _toList(result);
  }

  Future<List<SubCategory>> _toList(List<Map<String, dynamic>> result) async {
    final List<SubCategory> subCategories = [];

    for (Map<String, dynamic> row in result) {
      final int categoryId = row[_categoryId];
      final Category category =
          await CategoryDao().findCategory(database, categoryId);
      print("Categoria achada ${category.name}");
      final SubCategory subCategory = await _fromMap(row, category);
      subCategories.add(subCategory);
    }
    return subCategories;
  }

  Future<SubCategory> _fromMap(
      Map<String, dynamic> map, Category category) async {
    final subCategoryId = map['id'];

    return SubCategory(
      subCategoryId,
      map['name'],
      map['image_path'],
      map['section'],
      category,
    );
  }
}
