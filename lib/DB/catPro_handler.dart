import 'package:basic_sqflite/Model/catPro.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class CatProHelper {

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
    String path = join(documentDirectory.path, 'catPro.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate );
    return db;
  }

  _onCreate(Database db, int version) async {
    await  db.execute(
      "CREATE TABLE catpro (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,gender TEXT NOT NULL, species TEXT NOT NULL)",
    );
  }


  Future<CatProModel> insert(CatProModel catProModel) async {
    var dbClient = await db;
    await dbClient!.insert('catpro', catProModel.toMap());
    return catProModel;
  }


  Future<List<CatProModel>> getCatProList() async {
    var dbClient = await db;

    final List<Map<String, Object?>> queryResult = await dbClient!.query('catpro' );
    return queryResult.map((e) => CatProModel.fromMap(e)).toList();

  }



  Future deleteTableContent() async {
    var dbClient = await db;
    return await dbClient!.delete(
      'catpro',
    );
  }


  Future<int> updateQuantity(CatProModel catProModel) async {
    var dbClient = await db;
    return await dbClient!.update(
      'catpro',
      catProModel.toMap(),
      where: 'id = ?',
      whereArgs: [catProModel.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    var dbClient = await db;
    return await dbClient!.delete(
      'catpro',
      where: 'id = ?',
      whereArgs: [id],
    );
  }



  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }


}