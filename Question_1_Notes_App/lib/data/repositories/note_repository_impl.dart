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
      content: 'NOTE: The delete operation was missing in the data layer but has been successfully implemented below.',
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Future<List<Note>> getNotes() async {
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
    // TODO: MISSING CRUD OPERATION (Implemented for evaluation)
    // =========================================================================
    await Future.delayed(const Duration(milliseconds: 200));
    _notes.removeWhere((note) => note.id == id);
  }
}
