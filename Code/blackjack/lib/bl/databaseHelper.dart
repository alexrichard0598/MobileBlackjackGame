import 'dart:io';

import 'package:blackjack/bl/profile.dart';
import "package:path/path.dart";
import "package:sqflite/sqflite.dart";
import "package:path_provider/path_provider.dart";

class DatabaseHelper {
  static final _databaseName = "blackjackStats.db";
  static final _databaseVersion = 1;

  static final table = "Profiles";

  static final colId = "ID";
  static final colName = "Name";
  static final colWins = "Wins";
  static final colLosses = "Losses";
  static final colPlayerBlackjacks = "PlayerBlackjacks";
  static final colDealerBlackjacks = "DealerBlackjacks";
  static final colTotalGames = "TotalGames";
  static final colTotalPlayerHands = "TotalPlayerHands";
  static final colTotalDealerHands = "TotalDealerHands";

  //Make this a stingleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // this opens the database and creates it if it doesn't exit
  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    print(path);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  //SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE $table (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colName TEXT NOT NULL,
        $colWins INTERGER NOT NULL,
        $colLosses INTERGER NOT NULL,
        $colPlayerBlackjacks INTERGER NOT NULL,
        $colDealerBlackjacks INTERGER NOT NULL,
        $colTotalGames INTERGER NOT NULL,
        $colTotalPlayerHands INTERGER NOT NULL,
        $colTotalDealerHands INTERGER NOT NULL
      );
    """);
  }

  //Only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<int> insert(Profile profile) async {
    Database db = await instance.database;
    return await db.insert(table, profile.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryByID(id) async {
    Database db = await instance.database;
    return await db.query(table, where: "$colId = $id");
  }

  Future<List<Map<String, dynamic>>> queryByName(name) async {
    Database db = await instance.database;
    return await db.query(table, where: "$colName = '$name'");
  }

  Future<int> update(Profile profile) async {
    Database db = await instance.database;
    int id = profile.id;
    return await db
        .update(table, profile.toMap(), where: "$colId = ?", whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: "$colId = ?", whereArgs: [id]);
  }
}
