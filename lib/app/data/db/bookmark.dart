import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  DatabaseManager._private();

  static DatabaseManager instance = DatabaseManager._private();

  Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initdDB();
    }

    return _db!;
  }

  Future _initdDB() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();

    String path = join(docDirectory.path, "bookmark.db");

    return await openDatabase(path, version: 1,
        onCreate: (database, version) async {
      await database.execute('''
CREATE TABLE bookmark(
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  surah TEXT NOT NULL,
  ayat INTEGER NOT NULL,
  juz INTEGER NOT NULL,
  via TEXT NOT NULL,
  index_ayat INTEGER NOT NULL,
  last_read INTEGER DEFAULT 0
)
''');
    });
  }

  Future closeDB() async {
    _db = await instance.db;
    _db!.close();
  }
}
