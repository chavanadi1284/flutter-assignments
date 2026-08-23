import '../models/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getNotes();
  Future<void> addNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String id); // NOTE: This CRUD operation is to be implemented by the student
}
