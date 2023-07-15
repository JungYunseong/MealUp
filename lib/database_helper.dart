import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/food_item.dart';
import 'model/intakes.dart';

class DatabaseHelper {
  static const _databaseName = 'meal_up_intakes.db';
  static const _databaseVersion = 1;

  static const tableIntakes = 'intakes';
  static const tableFoodItems = 'food_items';

  static const columnId = 'id';
  static const columnDate = 'date';

  static const columnFoodItemId = 'food_item_id';
  static const columnType = 'type';
  static const columnThumbnail = 'thumbnail';
  static const columnName = 'name';
  static const columnCarb = 'carb';
  static const columnProtein = 'protein';
  static const columnFat = 'fat';
  static const columnIntakesId = 'intakes_id';

  Database? _database;
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, _databaseName);
    return await openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableIntakes (
        $columnId INTEGER PRIMARY KEY,
        $columnDate TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableFoodItems (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnThumbnail TEXT,
        $columnType TEXT NOT NULL,
        $columnName TEXT NOT NULL,
        $columnCarb INTEGER NOT NULL,
        $columnProtein INTEGER NOT NULL,
        $columnFat INTEGER NOT NULL,
        $columnFoodItemId INTEGER,
        $columnIntakesId INTEGER NOT NULL,
        FOREIGN KEY ($columnIntakesId) REFERENCES $tableIntakes ($columnId)
      )
    ''');
  }

  // Intakes CRUD operations

  Future<int> createIntake(Intakes intake) async {
    final db = await instance.database;
    final intakeId = await db.insert(tableIntakes, {
      columnId: intake.id,
      columnDate: intake.date,
    });

    await createFoodItems(intake.breakfast, intakeId);
    await createFoodItems(intake.lunch, intakeId);
    await createFoodItems(intake.dinner, intakeId);

    return intakeId;
  }

  Future<Intakes?> getIntake(int id) async {
    final db = await instance.database;
    final intake =
        await db.query(tableIntakes, where: '$columnId = ?', whereArgs: [id]);

    if (intake.isEmpty) return null;

    final breakfast = await getFoodItemsForIntake(id, 'breakfast');
    final lunch = await getFoodItemsForIntake(id, 'lunch');
    final dinner = await getFoodItemsForIntake(id, 'dinner');

    return Intakes(
      id: intake[0][columnId] as int,
      date: intake[0][columnDate] as String,
      breakfast: breakfast,
      lunch: lunch,
      dinner: dinner,
    );
  }

  Future<List<Intakes>> getAllIntakes() async {
    final db = await instance.database;
    final intakes = await db.query(tableIntakes);

    final List<Intakes> allIntakes = [];
    for (final intake in intakes) {
      final id = intake[columnId] as int;
      final breakfast = await getFoodItemsForIntake(id, 'breakfast');
      final lunch = await getFoodItemsForIntake(id, 'lunch');
      final dinner = await getFoodItemsForIntake(id, 'dinner');

      allIntakes.add(
        Intakes(
          id: intake[columnId] as int,
          date: intake[columnDate] as String,
          breakfast: breakfast,
          lunch: lunch,
          dinner: dinner,
        ),
      );
    }

    return allIntakes;
  }

  Future<int> updateIntake(Intakes intake) async {
    final db = await instance.database;
    final rowsAffected = await db.update(
      tableIntakes,
      {columnDate: intake.date},
      where: '$columnDate = ?',
      whereArgs: [intake.id],
    );

    await deleteFoodItemsForIntake(intake.id);
    await createFoodItems(intake.breakfast, intake.id);
    await createFoodItems(intake.lunch, intake.id);
    await createFoodItems(intake.dinner, intake.id);

    return rowsAffected;
  }

  Future<int> deleteIntake(int id) async {
    final db = await instance.database;
    await deleteFoodItemsForIntake(id);
    return await db
        .delete(tableIntakes, where: '$columnId = ?', whereArgs: [id]);
  }

  // FoodItems CRUD operations

  Future<void> createFoodItems(List<FoodItem> foodItems, int intakeId) async {
    final db = await instance.database;
    for (final foodItem in foodItems) {
      await db.insert(tableFoodItems, {
        columnType: foodItem.type,
        columnThumbnail: foodItem.thumbnail,
        columnName: foodItem.name,
        columnCarb: foodItem.carb,
        columnProtein: foodItem.protein,
        columnFat: foodItem.fat,
        columnFoodItemId: foodItem.id,
        columnIntakesId: intakeId,
      });
    }
  }

  Future<List<FoodItem>> getFoodItemsForIntake(
      int intakeId, String type) async {
    final db = await instance.database;
    final foodItems = await db.query(
      tableFoodItems,
      where: '$columnIntakesId = ? AND $columnType = ?',
      whereArgs: [intakeId, type],
    );

    return foodItems
        .map((foodItem) => FoodItem(
              id: foodItem[columnId] as int,
              type: foodItem[columnType] as String,
              thumbnail: foodItem[columnThumbnail] as String?,
              name: foodItem[columnName] as String,
              carb: foodItem[columnCarb] as int,
              protein: foodItem[columnProtein] as int,
              fat: foodItem[columnFat] as int,
            ))
        .toList();
  }

  Future<void> deleteFoodItemsForIntake(int intakeId) async {
    final db = await instance.database;
    await db.delete(tableFoodItems,
        where: '$columnIntakesId = ?', whereArgs: [intakeId]);
  }
}
