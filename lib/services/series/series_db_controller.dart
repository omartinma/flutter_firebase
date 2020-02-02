import 'dart:async';
import 'dart:io';
import 'package:flutter_firebase/model/serie.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class SeriesDBController {
  final String serieTableName = "Serie";

  SeriesDBController._();

  static final SeriesDBController instance = SeriesDBController._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "series.db");
    return await openDatabase(path,
        version: 1, onUpgrade: _onUpgrade, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int) async {
    await db.execute("CREATE TABLE Serie ("
        "id integer primary key,"
        "name TEXT,"
        "posterPath TEXT,"
        "backdropPath TEXT,"
        "voteAverage real,"
        "genre TEXT,"
        "overview TEXT"
        ")");
  }

  // UPGRADE DATABASE TABLES
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      //await db.execute("ALTER TABLE Serie ADD COLUMN newColumn TEXT;");
    }
  }

  addSerie(Serie serie) async {
    final db = await database;
    var raw = await db.insert(
      serieTableName,
      serie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  Future<List<Serie>> getAllSeries() async {
    final db = await database;
    var response = await db.query(serieTableName);
    List<Serie> list = response.map((c) => Serie.fromMap(c)).toList();
    return list;
  }

  removeSerie(int id) async {
    final db = await database;
    return db.delete(serieTableName, where: "id = ?", whereArgs: [id]);
  }

}
