import 'package:flutter/material.dart';
import 'package:note_app_flutter/model/note.dart';
import 'package:note_app_flutter/repository/note_repository.dart';

class NoteProvider extends ChangeNotifier {
  final NoteRepository _noteRepository = NoteRepository();
  final List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> fetchNotes() async {
    final fetchedNotes = await _noteRepository.getAllNotes();
    _notes.clear();
    _notes.addAll(fetchedNotes);
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await _noteRepository.insertNote(note);
    fetchNotes();
  }

  Future<void> updateNote(Note updatedNote) async {
    await _noteRepository.updateNote(updatedNote);
    fetchNotes();
  }

  Future<void> deleteNote(String id) async {
    await _noteRepository.deleteNote(id);
    fetchNotes();
  }
}
