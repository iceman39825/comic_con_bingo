import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:comic_con_bingo/Models/CellValue.dart';

class DatabaseHelper {
  static final DatabaseHelper _dbHelper = DatabaseHelper._internal();
  String tblCellValues = "CellValues";
  String colId = "id";
  String colValue = "value";

  DatabaseHelper._internal();

  factory DatabaseHelper(){
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async{
    if(_db == null){
      _db = await initializeDb();
    }

    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "values.db";
    var dbValues = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbValues;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $tblCellValues($colId INTEGER PRIMARY KEY, $colValue TEXT)");

    var values = ["Deadpool", "Harley Quinn", "Goku", "Marty McFly", "Batman", "Spider-man", "Wonder Woman", "Naruto",
                  "Chewbacca", "Mario", "D.Va", "Thor", "Iron Man", "Captain America", "Loki", "Mercy", "Wolverine",
                  "Green Lantern", "Flash", "Power Ranger", "Link", "Finn", "Harry Potter", "Poison Ivy", "Joker"];

    for(int i = 0; i < values.length; i++) {
      await db.execute("INSERT INTO $tblCellValues ($colValue) VALUES (" + values[i] + ")");
    }
  }

  Future<int> insertCellValue(CellValue value) async{
    Database db = await this.db;
    var result = await db.insert(tblCellValues, value.toMap());
    return result;
  }

  Future<List> getCellValues() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblCellValues");

    return result;
  }

  Future<int> getCount() async{
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT (*) FROM $tblCellValues")
    );

    return result;
  }

  Future<int> updateCellValue(CellValue value) async {
    var db = await this.db;
    var result = await db.update(tblCellValues, value.toMap(),
        where: "$colId = ?", whereArgs: [value.id]);

    return result;
  }

  Future<int> deleteCellValue(int id) async {
    var db = await this.db;
    var result = await db.rawDelete("DELETE FROM $tblCellValues WHERE $colId = $id");

    return result;
  }
}