import 'package:fono_terapia/shared/assets/app_assets.dart';
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
    AppAssets.logoCompreensaoAuditiva,
    AppAssets.logoCompreensaoEscrita,
    AppAssets.logoNomeacaoOral,
    AppAssets.logoNomeacaoEscrita,
  ];

  static String get tableSql {
    return '''CREATE TABLE $tableName(
      $_id INTEGER PRIMARY KEY AUTOINCREMENT,
      $_name TEXT NOT NULL,
      $_imagePath TEXT NOT NULL);''';
  }

  static String get tableData {
    return "INSERT INTO $tableName ($_name, $_imagePath) VALUES "
        "('${categoryNames[0]}', '${imagePathList[0]}'),"
        "('${categoryNames[1]}', '${imagePathList[1]}'),"
        "('${categoryNames[2]}', '${imagePathList[2]}'),"
        "('${categoryNames[3]}', '${imagePathList[3]}');";
  }

  Future<List<Category>> findAllCategories(Database db) async {
    final List<Map<String, dynamic>> result = await db.query(tableName);
    List<Category> categories = _toList(result);
    return categories;
  }

  Future<Category> findCategory(Database db, int categoryId) async {
    final List<Map<String, Object?>> result =
        await db.query(tableName, where: '$_id = $categoryId');
    return _fromMap(result.first);
  }

  Category _fromMap(Map<String, dynamic> map) {
    return Category(
      map['id'],
      map['name'],
      map['image_path'],
    );
  }

  List<Category> _toList(List<Map<String, dynamic>> result) {
    final List<Category> categories = [];

    for (Map<String, dynamic> row in result) {
      final Category category = Category(row[_id], row[_name], row[_imagePath]);
      categories.add(category);
    }
    return categories;
  }
}
