import 'package:flutter/material.dart';
import '../../domain/models/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../../data/repositories/note_repository_impl.dart';

class NotesProvider extends ChangeNotifier {
  final NoteRepository _repository = NoteRepositoryImpl();

  List<Note> _notes = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchNotes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _notes = await _repository.getNotes();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addNote(String title, String content) async {
    _isLoading = true;
    notifyListeners();

    try {
      final newNote = Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        content: content,
        createdAt: DateTime.now(),
      );
      await _repository.addNote(newNote);
      await fetchNotes();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateNote(String id, String title, String content) async {
    _isLoading = true;
    notifyListeners();

    try {
      final updatedNote = Note(
        id: id,
        title: title,
        content: content,
        createdAt: DateTime.now(),
      );
      await _repository.updateNote(updatedNote);
      await fetchNotes();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<String?> deleteNote(String id) async {
    try {
      await _repository.deleteNote(id);
      await fetchNotes();
      return null;
    } on UnimplementedError catch (e) {
      return e.message ?? 'Unimplemented operation';
    } catch (e) {
      return e.toString();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
