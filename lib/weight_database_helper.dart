import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/weight.dart';

class WeightDatabaseHelper {
  static final WeightDatabaseHelper _instance =
      WeightDatabaseHelper._internal();

  factory WeightDatabaseHelper() => _instance;

  WeightDatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'weight_dataddddase.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE weight_entries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date INTEGER NOT NULL,
            weight REAL NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertWeightEntry(WeightEntry entry) async {
    final db = await database;
    return await db.insert('weight_entries', entry.toMap());
  }

  Future<List<WeightEntry>> getWeightEntries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'weight_entries',
    );
    return List.generate(maps.length, (i) {
      return WeightEntry.fromMap(maps[i]);
    });
  }

  Future<int> updateWeightEntry(WeightEntry entry) async {
    final db = await database;
    return await db.update(
      'weight_entries',
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  Future<int> deleteWeightEntry(int id) async {
    final db = await database;
    return await db.delete(
      'weight_entries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
