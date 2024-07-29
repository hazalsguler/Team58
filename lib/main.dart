import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Tasks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotesPage(),
    );
  }
}

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<String> _notes = [];
  TextEditingController _controller = TextEditingController();
  late File _jsonFile; // 'late' anahtar kelimesi ile bildirildi
  late String _path;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final directory = await getApplicationDocumentsDirectory();
    _path = '${directory.path}/notes.json';
    _jsonFile = File(_path);

    if (await _jsonFile.exists()) {
      final contents = await _jsonFile.readAsString();
      final json = jsonDecode(contents);
      setState(() {
        _notes = List<String>.from(json);
      });
    } else {
      // Load default notes from assets if file does not exist
      final data = await rootBundle.loadString('assets/notes.json');
      final json = jsonDecode(data);
      setState(() {
        _notes = List<String>.from(json);
      });
      _saveNotes(); // Save default notes to app documents
    }
  }

  Future<void> _saveNotes() async {
    final json = jsonEncode(_notes);
    await _jsonFile.writeAsString(json);
  }

  void _addNote() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _notes.add(_controller.text);
        _controller.clear();
      });
      _saveNotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quick Tasks'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'New Note'),
            ),
          ),
          ElevatedButton(
            onPressed: _addNote,
            child: Text('Add Note'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_notes[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
