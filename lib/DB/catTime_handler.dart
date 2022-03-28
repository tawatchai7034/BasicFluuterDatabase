import 'package:basic_sqflite/Model/catTime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class CatTimeHelper {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'catTime.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE cattime(id INTEGER PRIMARY KEY, idPro INTEGER,bodyLenght REAL,heartGirth REAL,hearLenghtSide REAL,hearLenghtRear REAL,hearLenghtTop REAL,pixelReference REAL,distanceReference REAL,imageSide INTEGER, imageRear INTEGER, imageTop INTEGER,date TEXT,note TEXT)",
    );
  }

  Future<CatTimeModel> insert(CatTimeModel catTimeModel) async {
    var dbClient = await db;
    await dbClient!.insert('cattime', catTimeModel.toMap());
    return catTimeModel;
  }

  Future<List<CatTimeModel>> getAllCatTimeList() async {
    var dbClient = await db;

    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('cattime');
    return queryResult.map((e) => CatTimeModel.fromMap(e)).toList();
  }

  Future<List<CatTimeModel>> getCatTimeListWithCatProID(int idPro) async {
    var dbClient = await db;

    final List<Map<String, Object?>> queryResult = await dbClient!.rawQuery("SELETE * FROM cattime WHERE idPro = ?",[idPro]);
    return queryResult.map((e) => CatTimeModel.fromMap(e)).toList();
  }

  Future deleteTableContent() async {
    var dbClient = await db;
    return await dbClient!.delete(
      'cattime',
    );
  }

  Future<int> updateQuantity(CatTimeModel catTimeModel) async {
    var dbClient = await db;
    return await dbClient!.update(
      'cattime',
      catTimeModel.toMap(),
      where: 'id = ?',
      whereArgs: [catTimeModel.id],
    );
  }

  Future<int> deleteCatTime(int id) async {
    var dbClient = await db;
    return await dbClient!.delete(
      'cattime',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteCatTimeWithIdPro(int idPro) async {
    var dbClient = await db;
    return await dbClient!.delete(
      'cattime',
      where: 'idPro = ?',
      whereArgs: [idPro],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }
}
