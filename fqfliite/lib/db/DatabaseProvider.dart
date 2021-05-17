import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class DatabaseProvider {
  static final DB_NAME = 'form.db';
  static final DB_VERSION = 1;
  static final TABLE_NAME = 'LOGIN';
  static final COLUMN_ID = 'ID';
  static final COLUMN_NAME = 'NAME';
  static final COLUMN_PASSWORD = 'PASSWORD';

  DatabaseProvider._privateConstructor();

  static DatabaseProvider instance = DatabaseProvider._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initiateDatabse();
    return _database;
  }

  initiateDatabse() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, DB_NAME);
    return await openDatabase(path,
        version: DB_VERSION, onCreate: createDatabase);
  }

  createDatabase(Database database, int version) async {
    print('oncreate');
    database.execute(
        'CREATE TABLE $TABLE_NAME ($COLUMN_ID INTEGER PRIMARY KEY, $COLUMN_NAME TEXT NOT NULL, $COLUMN_PASSWORD TEXT)');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database database = await instance.database;
    int id = await database.insert(TABLE_NAME, row);
    return id;
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database database = await instance.database;
    return database.query(TABLE_NAME);
  }
}
