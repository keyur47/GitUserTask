import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper db = DatabaseHelper._();
}

Database? gitUser;

Future<Database?> get initDatabase async {
  if (gitUser != null) {
    return gitUser;
  }

  gitUser = await initCartDB();
  return gitUser;
}

initCartDB() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, "gitUser.db");
  return await openDatabase(path, version: 3, onOpen: (db) {
    log("DB OPEN");
  }, onCreate: (Database db, int version) async {
    log("DB Created");
    await db.execute("CREATE TABLE gitUser("
        "id TEXT PRIMARY KEY,"
        "title TEXT,"
        "image TEXT,"
        "subTitle TEXT"
        ")");
  });
}

Future<void> deleteDatabase() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, "gitUser.db");
  return databaseFactory.deleteDatabase(path);
}
