import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHealper {
  Future<int> deleteUser(int id) async {
    final db = await initDB();
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await initDB();
    final result = await db.query('users');
    return result;
  }

  Future<Map<String, dynamic>?> getUserByPhone(String phone) async {
    final db = await initDB();
    final result = await db.query(
      'users',
      where: 'phone=?',
      whereArgs: [phone],
    );
    if (result.isNotEmpty) {
    print("dfgdfs");
      return result.first;
    } else {
      return null;
    }
  }

  Future<int> insertUser({
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    final db = await initDB();

    return await db.insert('users', {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
    });
  }

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final Path = join(dbPath, 'first1.db');

    return await openDatabase(
      Path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT,firstName TEXT NOT NULL,lastName TEXT NOT NULL, phone TEXT NOT NULL UNIQUE)
          ''');
        print('database created');
      },
    );
  }

  Future<int> updateUser({
    required int id,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    final db = await initDB();
    return await db.update(
      'users',
      {'firstName': firstName, 'lastName': lastName, 'phone': phone},
      where: 'id=?',
      whereArgs: [id],
    );
  }
}
