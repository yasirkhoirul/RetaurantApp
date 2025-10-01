import 'package:restaurant_app/api/model/restoran_model.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static const _databasename = 'Restoran.db';
  static const _tablename = 'favourite';
  static const int _version = 1;

  Future createTable(Database database) async {
    await database.execute("""
      create table $_tablename(
      id Text primary key not null,
      name Text,
      description Text,
      pictureId Text,
      city text,
      rating Real
      )
      """);
  }

  Future<Database> _initializeDB() async {
    return openDatabase(
      _databasename,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTable(database);
      },
    );
  }

  Future deleteItem(String id) async {
    final db = await _initializeDB();
    final result = await db.delete(
      _tablename,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<List<Restoran>> getAllFavrestoran() async {
    final db = await _initializeDB();
    final result = await db.query(_tablename, orderBy: "id");
    return result.map((e) => Restoran.fromjson(e)).toList();
  }

  Future insertRestoran(Restoran resto) async {
    final db = await _initializeDB();
    final data = resto.toJson();
    final id = await db.insert(
      _tablename,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }
}
