// Create a Flutter Notes application that stores notes (title and content) in an SQLite database and displays them in a ListView.
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NotesApp(),
  ));
}

class NotesApp extends StatefulWidget {
  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  Database? db;
  List<Map<String, dynamic>> notes = [];

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  Future<void> initDB() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT)',
        );
      },
    );
    loadNotes();
  }

  Future<void> loadNotes() async {
    notes = await db!.query('Notes', orderBy: 'id DESC');
    setState(() {});
  }

  Future<void> addNote() async {
    if (title.text.isEmpty || content.text.isEmpty) return;

    await db!.insert('Notes', {
      'title': title.text,
      'content': content.text,
    });

    title.clear();
    content.clear();
    loadNotes();
  }

  @override
  void initState() {
    super.initState();
    initDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Notes App'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(
                labelText: 'Note Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: content,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Note Content',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addNote,
              child: Text('Add Note'),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(notes[index]['title']),
                      subtitle: Text(notes[index]['content']),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}