import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {

  //Private constructor, so only this class can create a single instance of itself resulting in a singleton
  DBProvider._();

  //public variable our main will use to access database functions
  static final DBProvider provider = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }


  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Habit ("
              "id INTEGER PRIMARY KEY,"
              "name TEXT,"
              "dateCreated TEXT,"
              "lastReset TEXT,"
              "good BIT"
              ")");
        });
  }

}