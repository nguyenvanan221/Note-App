import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  // private constructor
  AppDatabase._();
  // Singleton instance
  static final AppDatabase instance = AppDatabase._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await init();
    return _database!;
  }

  Future<Database> init() async {
    final path = join(await getDatabasesPath(), 'app.db');
    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return _database!;
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE notes (
            id INTEGER,
            title TEXT,
            content TEXT,
            favorite INTEGER
          )
      ''');
    } catch (e) {
      print('Error creating database: $e');
    }
  }
}
