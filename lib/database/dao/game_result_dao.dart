import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/database/dao/sub_category_dao.dart';
import 'package:fono_terapia/shared/model/game_result.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:sqflite/sqflite.dart';

class GameResultDao {
  static const tableName = 'game_results';
  static const _id = 'id';
  static const _date = 'date';
  static const _totalQuestions = 'total_questions';
  static const _answeredCorrectly = 'answered_correctly';
  static const _subCategoryId = 'sub_category_id';
  static const _subCategoryTableName = SubCategoryDao.tableName;

  static String get tableSql {
    return '''CREATE TABLE $tableName(
        $_id INTEGER PRIMARY KEY AUTOINCREMENT,
        $_date TEXT NOT NULL,
        $_totalQuestions INTEGER NOT NULL,
        $_answeredCorrectly INTEGER NOT NULL,
        $_subCategoryId INTEGER NOT NULL,
        FOREIGN KEY ($_subCategoryId) REFERENCES $_subCategoryTableName($_id)
      );''';
  }

  Future<void> insert(GameResult gameResult, Database db) async {
    // Define o ID como null antes de inserir
    gameResult.id = null;
    await db.insert(
      tableName,
      _toMap(gameResult),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print(gameResult);
  }

  Future<List<GameResult>> findAll(Database db) async {
    final List<Map<String, dynamic>> result = await db.query(tableName);
    List<GameResult> gameResults = await _toList(result);
    return gameResults;
  }

  Future<List<GameResult>> _toList(List<Map<String, dynamic>> result) async {
    final List<GameResult> gameResults = [];

    for (Map<String, dynamic> row in result) {
      final int subCategoryId = row[_subCategoryId];
      final SubCategory subCategory =
          await SubCategoryDao().findSubCategory(database, subCategoryId);
      final GameResult gameResult = _fromMap(row, subCategory);
      gameResults.add(gameResult);
    }
    return gameResults;
  }

  Map<String, dynamic> _toMap(GameResult gameResult) {
    return {
      _id: gameResult.id,
      _date: gameResult.date,
      _totalQuestions: gameResult.totalQuestions,
      _answeredCorrectly: gameResult.answeredCorrectly,
      _subCategoryId: gameResult.subCategory.id,
    };
  }

  GameResult _fromMap(Map<String, dynamic> map, SubCategory subCategory) {
    return GameResult(
      map[_id],
      map[_date],
      map[_totalQuestions],
      map[_answeredCorrectly],
      subCategory,
    );
  }
}
