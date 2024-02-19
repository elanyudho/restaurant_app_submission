import 'package:sqflite/sqflite.dart';

import '../remote/response/restaurant_list.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();


  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableName = 'favorite_restaurants';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurants.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tableName (
           id TEXT PRIMARY KEY,
           name TEXT,
           title TEXT,
           pictureId TEXT,
           city TEXT,
           description TEXT,
           rating DOUBLE
         )     
      ''');
      },
      version: 1,
    );

    return db;
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db.insert(_tableName, restaurant.toJson());
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Restaurant>> getFavoriteRestaurants() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }
}