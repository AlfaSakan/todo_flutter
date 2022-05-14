import 'package:flutter/foundation.dart';
import '../models/models.dart';

class NotesList with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get getNotes => _notes;

  void addNote(Note value) {
    _notes.add(value);
    sortNote();
  }

  void sortNote() {
    _notes.sort(
      (a, b) {
        return a.getTime - b.getTime;
      },
    );
    notifyListeners();
  }

  void removeNoteAt(int indexItem) {
    _notes.removeAt(indexItem);
    sortNote();
  }

  void resetCart() {
    _notes = [];
    notifyListeners();
  }
}
