import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'note_storage.dart';

void main() {

  runApp(const NotesApp());

}

class NotesApp extends StatefulWidget {

  const NotesApp({super.key});

  @override

  State<NotesApp> createState() => _NotesAppState();

}

class _NotesAppState extends State<NotesApp> {

  bool _isDarkMode = false;

  final NoteStorage _storage = NoteStorage();

  final TextEditingController _noteController =

      TextEditingController();

  String _status = '';

  @override

  void initState() {

    super.initState();

    _loadThemePreference();

  }

  Future<void> _loadThemePreference() async {

    final prefs = await SharedPreferences.getInstance();

    setState(() {

      _isDarkMode = prefs.getBool('isDarkMode') ?? false;

    });

  }

  Future<void> _updateTheme(bool newValue) async {

    setState(() {

      _isDarkMode = newValue;

    });

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isDarkMode', newValue);

  }

  Future<void> _saveNote() async {

    try {

      await _storage.writeNote(_noteController.text);

      setState(() {

        _status = 'Note saved to disk!';

      });

    } catch (e) {

      setState(() {

        _status = 'Error saving note.';

      });

    }

  }

  Future
<void> _updateTheme(bool newValue) async {

    setState(() {

      _isDarkMode = newValue;

    });

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isDarkMode', newValue);

  }

  Future<void> _saveNote() async {

    try {

      await _storage.writeNote(_noteController.text);

      setState(() {

        _status = 'Note saved to disk!';

      });

    } catch (e) {

      setState(() {

        _status = 'Error saving note.';

      });

    }

  }

  Future<void> _printNote() async {

    try {

      String content = await _storage.readRawContent();

      debugPrint(content);

      setState(() {

        _status = 'Note printed to console!';

      });

    } catch (e) {

      setState(() {

        _status = 'Could not read note.';

      });

    }

  }

  @override

  void dispose() {

    _noteController.dispose();

    super.dispose();

  }

  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Personal Notes',

      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),

      home: Scaffold(

        appBar: AppBar(

          title: const Text('Personal Notes App'),

        ),

        body: Padding(

          padding: const EdgeInsets.all(16),

          child: Column(

            children: [

              SwitchListTile(

                title: const Text('Dark Mode'),

                value: _isDarkMode,

                onChanged: _updateTheme,

              ),

              const SizedBox(height: 20),

              TextField(

                controller: _noteController,

                maxLines: 5,

                decoration: const InputDecoration(

                  hintText: 'Type your notes here...',

                  border: OutlineInputBorder(),

                ),

              ),

              const SizedBox(height: 15),

              ElevatedButton(

                onPressed: _saveNote,
child: const Text('Save Note'),

              ),

              OutlinedButton(

                onPressed: _printNote,

                child: const Text('Print File to Console'),

              ),

              const SizedBox(height: 15),

              Text(_status),

            ],

          ),

        ),

      ),

    );

  }

}
