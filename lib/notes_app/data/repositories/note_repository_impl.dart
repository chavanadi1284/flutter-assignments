import '../../domain/models/note.dart';
import '../../domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  // In-memory list simulating a database/local storage
  final List<Note> _notes = [
    Note(
      id: '1',
      title: 'Welcome Note',
      content: 'Welcome to your Notes App! This application implements clean architecture separating Domain, Data, and Presentation layers.',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Note(
      id: '2',
      title: 'Dart & Flutter Tips',
      content: 'Keep UI clean and lightweight. Use BLoC, Provider, or Riverpod for handling state management efficiently.',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Note(
      id: '3',
      title: 'Assignment Evaluation',
      content: 'NOTE: One CRUD operation (Delete) is intentionally left unimplemented in this data layer class. Check deleteNote() for details.',
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Future<List<Note>> getNotes() async {
    // Simulating network or database latency
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_notes);
  }

  @override
  Future<void> addNote(Note note) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _notes.insert(0, note);
  }

  @override
  Future<void> updateNote(Note note) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note;
    } else {
      throw Exception('Note with ID ${note.id} not found.');
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    // =========================================================================
    // TODO: MISSING CRUD OPERATION (Part of the 75 Marks Assignment)
    //
    // Instructions: Implement this method to delete a note from the list.
    // =========================================================================
    await Future.delayed(const Duration(milliseconds: 200));
    _notes.removeWhere((note) => note.id == id);
  }
}
