import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:swastha/models/data_model.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE swastha(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        date TEXT,
        day INTEGER,
        water INTEGRE,
        calories INTEGRE,
        steps INTEGRE,
        sleep INTEGRE
      )
      """);
  }
// id: the id of a item
// title, waterTaken: name and waterTaken of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'swastha.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> insertData(DataModel dataModel) async {
    final date = DateFormat('dd/MM/yyyy').format(DateTime.now());
    final db = await SQLHelper.db();
    final list = await SQLHelper.getItem(date);

    if (list.length == 1) {
      if (dataModel.water != 0) {
        final result = await db.update(
            'swastha', {'water': (list[0]['water'] as int) + dataModel.water},
            where: "date = ?", whereArgs: [date]);
        return result;
      } else if (dataModel.sleep != 0) {
        final result = await db.update(
            'swastha', {'sleep': (list[0]['sleep'] as int) + dataModel.sleep},
            where: "date = ?", whereArgs: [date]);
        return result;
      } else if (dataModel.calories != 0) {
        final result = await db.update('swastha',
            {'calories': (list[0]['calories'] as int) + dataModel.calories},
            where: "date = ?", whereArgs: [date]);
        return result;
      } else if (dataModel.steps != 0) {
        final result = await db.update('swastha', {'steps': dataModel.steps},
            where: "date = ?", whereArgs: [date]);
        return result;
      } else {
        return 0;
      }
    } else {
      final id = await db.insert('swastha', dataModel.toMap(),
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
      return id;
    }
  }

  // Create new item (journal)
  static Future<int> createItem(int waterTaken, String date, String day) async {
    final db = await SQLHelper.db();
    final list = await SQLHelper.getItem(date);
    if (list.length == 1) {
      final result = await SQLHelper.updateItem(
          date, waterTaken + (list[0]['waterTaken'] as int), day);
      return result;
    } else {
      final data = {'waterTaken': waterTaken, 'date': date, 'day': day};
      final id = await db.insert('water', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
      return id;
    }
  }

  static Future<List<Map<String, dynamic>>> getWeeklyData() async {
    final db = await SQLHelper.db();
    final date = DateFormat('dd/MM/yyyy').format(DateTime.now());
    final result = await db.query('swastha', limit: 7);

    if (result.isEmpty) {
      final DataModel dataModel =
          DataModel(date, DateTime.now().weekday, 0, 0, 0, 0);
      await db.insert('swastha', dataModel.toMap(),
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
      return [dataModel.toMap()];
    } else {
      return result;
    }
  }

  static Future<List<Map<String, dynamic>>> getTodayData() async {
    final db = await SQLHelper.db();
    final date = DateFormat('dd/MM/yyyy').format(DateTime.now());
    final result = await db.query('swastha',
        where: "date = ?", whereArgs: [date], limit: 1);

    if (result.isEmpty) {
      final DataModel dataModel =
          DataModel(date, DateTime.now().weekday, 0, 0, 0, 0);
      await db.insert('swastha', dataModel.toMap(),
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
      return [dataModel.toMap()];
    } else {
      return result;
    }
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(String date) async {
    final db = await SQLHelper.db();
    return db.query('swastha', where: "date = ?", whereArgs: [date], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(String date, int waterTaken, String day) async {
    final db = await SQLHelper.db();

    final data = {'waterTaken': waterTaken, 'day': day};

    final result =
        await db.update('water', data, where: "date = ?", whereArgs: [date]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("water", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
