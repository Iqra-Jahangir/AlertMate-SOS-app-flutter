/*import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart'; // For mobile
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // For desktop
import '../models/contact.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  DatabaseHelper._privateConstructor();

  late final Database db;

  Future<void> init() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Desktop initialization
      sqfliteFfiInit();
      db = await databaseFactoryFfi.openDatabase(
        join(await getDatabasesPath(), 'contacts.db'),
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: _onCreate,
        ),
      );
    } else {
      // Mobile initialization
      db = await openDatabase(
        join(await getDatabasesPath(), 'contacts.db'),
        version: 1,
        onCreate: _onCreate,
      );
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        number TEXT NOT NULL
      )
    ''');
  }

  Future<List<Contact>> getContacts() async {
    final List<Map<String, dynamic>> maps = await db.query('contacts');
    return List.generate(
      maps.length,
          (i) => Contact(
        id: maps[i]['id'],
        name: maps[i]['name'],
        number: maps[i]['number'],
      ),
    );
  }

  Future<void> insertContact(Contact contact) async {
    await db.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteContact(int id) async {
    await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}
*/