import 'package:note_app_flutter/database/app_database.dart';
import 'package:note_app_flutter/model/note.dart';
import 'package:sqflite/sqflite.dart';

class NoteRepository {
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<List<Note>> getAllNotes() async {
    final db = await _db;
    final data = await db.query('notes');
    return data.map((row) => Note.fromMap(row)).toList();
  }

  Future<int> insertNote(Note note) async {
    final db = await _db;
    return await db.insert('notes', note.toMap());
  }

  Future<int> updateNote(Note note) async {
    final db = await _db;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(String id) async {
    final db = await _db;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  // Future<int> updateFavoriteStatus(int id, bool favorite) async {
  //   return await db.update(
  //     'notes',
  //     {'favorite': favorite ? 1 : 0},
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  // }
}
