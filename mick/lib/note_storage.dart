import 'dart:io';
import 'package:path_provider/path_provider.dart';

class NoteStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/notes.txt');
  }

  Future<String> readNotes() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }

  Future<void> writeNotes(String notes) async {
    final file = await _localFile;
    await file.writeAsString(notes);
  }
}