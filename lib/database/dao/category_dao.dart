import 'package:fono_terapia/shared/model/category.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDao {
  static const tableName = 'categories';
  static const _id = 'id';
  static const _name = 'name';
  static const _imagePath = 'image_path';

  static const categoryNames = [
    'Compreensão Auditiva',
    'Compreensão Escrita',
    'Nomeação Oral',
    'Nomeação Escrita'
  ];

  static const imagePathList = [
    'assets/app_images/logoCompreensaoAuditiva.jpg',
    'assets/app_images/logoNomeacaoOral.jpg',
    'assets/app_images/logoCompreensaoEscrita.jpg',
    'assets/app_images/logoNomeacaoEscrita.jpg',
  ];

  static String get tableSql {
    return 'CREATE TABLE $tableName('
      '$_id INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_name TEXT NOT NULL, '
      '$_imagePath TEXT NOT NULL);';
  }

  static String get tableData {
    return "INSERT INTO $tableName ($_name, $_imagePath) VALUES "
    "('${categoryNames[0]}', '${imagePathList[0]}'),"
    "('${categoryNames[1]}', '${imagePathList[1]}'),"
    "('${categoryNames[2]}', '${imagePathList[2]}'),"
    "('${categoryNames[3]}', '${imagePathList[3]}');";
  }

  Future<List<Category>> findAll(Database db) async {
    final List<Map<String, dynamic>> result = await db.query(tableName);
    List<Category> categories = _toList(result);
    return categories;
  }

  List<Category> _toList(List<Map<String, dynamic>> result) {
    final List<Category> categories = [];

    for (Map<String, dynamic> row in result) {
      final Category category = Category(
        row[_id],
        row[_name],
        row[_imagePath]
      );
      categories.add(category);
    }
    return categories;
  }

}
