import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CategoriesService {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    }
    return _db;
  }

  initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'managly.db');

    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      '''
       CREATE TABLE "revenuecategories" (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "category" TEXT NOT NULL
       )
      ''',
    );
    log('revenues categories fetched correctly');
    await db.execute(
      '''
       CREATE TABLE "expensecategories" (
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "category" TEXT NOT NULL
       )
      ''',
    );
    log('expenses categories fetched correctly');
  }

  getData(String sql) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertAutoData(String table, Map<String, dynamic> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }

  updateDataAuto(String table, Map<String, dynamic> values, int id) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, values, where: 'id = $id');
    return response;
  }

  deleteDataAuto(String table, int id) async {
    Database? mydb = await db;
    await mydb!.delete(
      table,
      where: 'id = $id',
    );
  }
}
