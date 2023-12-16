import 'package:crud1/model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DatabaseHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'userInfo.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE userInfo(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, contact TEXT)");
  }

  Future<UserModel> insert(UserModel userModel) async {
    var dbClient = await db;
    await dbClient!.insert('userInfo', userModel.toMap());
    return userModel;
  }

  Future<List<UserModel>> getUsers() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('userInfo');
    return queryResult.map((e) => UserModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('userInfo', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(UserModel userModel) async {
    var dbClient = await db;
    return dbClient!.update('userInfo', userModel.toMap(),
        where: 'id =?', whereArgs: [userModel.id]);
  }
}
