import 'dart:ffi';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static DbHelper dbHelper = DbHelper._();

  DbHelper._();

  Database? database;

  Future<Database?> checkDB() async {
    if (database != null) {
      return database;
    } else {
      return await createDB();
    }
  }

  Future<Database> createDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'pratik.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE task (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,category TEXT,status INTEGER,date TEXT)";
        db.execute(query);
      },
    );
  }

  void insertData({
    required String name,
    required String category,
    required int status,
    required String date,
  }) async {
    database = await checkDB();

    database!.insert("task", {
      "name": name,
      "category": category,
      "status": status,
      "date": date,
    });
  }

  Future<List<Map>> readData() async {
    database = await checkDB();
    String query = "SELECT * FROM task";
    List<Map> dataList = await database!.rawQuery(query);
    return dataList;
  }

  Future<void> deleteData({required int id}) async {
    database = await checkDB();
    database!.delete("task", where: "id =? ", whereArgs: [id]);
  }

  Future<void> updateData(
      {required int id,
      required String name,
      required int status,
      required String category,
      required String date}) async {
    database = await checkDB();
    database!.update("task",
        {'name': name, 'status': status, 'category': category, 'date': date},
        where: "id = ?", whereArgs: [id]);
  }

  Future<void> updateStatusCode({
    required int id,
    required int status,
  }) async {
    database = await checkDB();
    database!.update(
        "task",
        {
          'status': status,
        },
        where: "id = ?",
        whereArgs: [id]);
  }

  Future<List<Map>> readDateData(String date) async {
    // print("==========================DATE   $date");
    database = await checkDB();
    String query = "SELECT * FROM task WHERE date='$date'";
    List<Map> dataList = await database!.rawQuery(query);
    print("------datalist------------$dataList");
    return dataList;
  }

}
