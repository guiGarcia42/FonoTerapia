import 'package:fono_terapia/database/dao/category_dao.dart';
import 'package:fono_terapia/database/dao/game_component_dao.dart';
import 'package:fono_terapia/database/dao/game_result_dao.dart';
import 'package:fono_terapia/database/dao/sub_category_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const _dbName = "fonoterapia.db";

Future<Database> openOrInitializeDatabase() async {
  final path = join(await getDatabasesPath(), _dbName);

  await deleteDatabase(path);
  print("Banco deletado");

  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      // Create tables
      await db.execute(CategoryDao.tableSql);
      await db.execute(SubCategoryDao.tableSql);
      await db.execute(GameComponentDao.tableSql);
      await db.execute(GameResultDao.tableSql);

      // Insert data
      await db.execute(CategoryDao.tableData);
      await db.execute(SubCategoryDao.tableData);
      await db.execute(GameComponentDao.tableData);

      // Close db
      await db.close();
    },
  );
}
