import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final path = join(await getDatabasesPath(), 'fonoterapia.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute();
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete,
  );
}