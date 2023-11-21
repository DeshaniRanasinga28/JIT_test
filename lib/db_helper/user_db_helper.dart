import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDatabaseHelper {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user.db');

    return await openDatabase(path, version: 1, onCreate: _onCreateUsers);
  }

  Future<void> _onCreateUsers(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY,
        username TEXT,
        password TEXT
      )
    ''');
  }

  Future<void> insertUser(String username, String password) async {
    final db = await database;
    await db!.insert(
      'users',
      {'username': username, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUser(String username) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    return result.isNotEmpty ? result.first : null;
  }
}
