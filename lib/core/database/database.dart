import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  Database _database;
  String _dbName = "foodstreet.db";
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}/${_dbName}";
    var database = await openDatabase(path, version: 1, onCreate: _createDB);
    return database;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(
        "create table foods(id integer primary key autoincrement, title text, desc text, fulldesc text, price integer, image text)");
  }
}
