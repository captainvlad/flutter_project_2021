import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbManager {
  static Database? _database;

  static const String dbName = "sequel_db.db";
  static final DbManager instance = DbManager._init();

  DbManager._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await open(dbName);
    return _database!;
  }

  Future _checkDatabaseExists(Database db, int version) async {
    await database;
  }

  Future<Database> open(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _checkDatabaseExists);
  }

  static Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future createTable(String query) async {
    Database db = await database;

    await db.execute(query);
  }

  static Future runSelectQuery(String query) async {
    Database db = await instance.database;

    List<Map> result = await db.rawQuery(
      query,
    );

    return result;
  }

  static Future runAddQuery(String query) async {
    Database db = await instance.database;

    db.rawInsert(
      query,
    );
  }

  static Future runDeleteQuery(String query) async {
    Database db = await instance.database;

    db.rawDelete(query);
  }

  static Future runUpdateQuery(String query) async {
    Database db = await instance.database;

    db.rawUpdate(query);
  }
}
