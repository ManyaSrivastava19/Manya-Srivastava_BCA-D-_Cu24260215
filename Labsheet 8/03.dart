// Extend the Notes application to delete a note by swiping it and display a SnackBar message. 

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

  int? editId;

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

  Future<void> saveNote() async {
    if (title.text.isEmpty || content.text.isEmpty) return;

    if (editId == null) {
      await db!.insert('Notes', {
        'title': title.text,
        'content': content.text,
      });
    } else {
      await db!.update(
        'Notes',
        {
          'title': title.text,
          'content': content.text,
        },
        where: 'id = ?',
        whereArgs: [editId],
      );
    }

    title.clear();
    content.clear();
    editId = null;
    loadNotes();
  }

  void editNote(Map<String, dynamic> note) {
    title.text = note['title'];
    content.text = note['content'];
    editId = note['id'];
    setState(() {});
  }

  Future<void> deleteNote(int id) async {
    await db!.delete(
      'Notes',
      where: 'id = ?',
      whereArgs: [id],
    );

    loadNotes();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Note deleted successfully!')),
    );
  }

  @override
  void initState() {
    super.initState();
    initDB();
  }

  @override
  void dispose() {
    title.dispose();
    content.dispose();
    super.dispose();
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
              onPressed: saveNote,
              child: Text(editId == null ? 'Add Note' : 'Update Note'),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];

                  return Dismissible(
                    key: ValueKey(note['id']),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(15),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      deleteNote(note['id']);
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(note['title']),
                        subtitle: Text(note['content']),
                        trailing: Icon(Icons.edit),
                        onTap: () => editNote(note),
                      ),
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
