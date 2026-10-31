// Create a Flutter application to delete a student record using the delete() method.
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final id = TextEditingController();
  String message = "";

  Future<Database> getDB() async {
    String path = join(await getDatabasesPath(), 'student.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            rollNumber INTEGER,
            course TEXT
          )
        ''');
      },
    );
  }

  Future<void> deleteStudent() async {
    if (id.text.isEmpty || int.tryParse(id.text) == null) {
      setState(() {
        message = "Please enter a valid Student ID!";
      });
      return;
    }

    Database db = await getDB();

    int result = await db.delete(
      'Students',
      where: 'id = ?',
      whereArgs: [int.parse(id.text)],
    );

    setState(() {
      message = result > 0
          ? "Student Record Deleted Successfully!"
          : "Student ID Not Found!";
    });

    id.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delete Student Record")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: id,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter Student ID",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: deleteStudent,
              child: Text("Delete Record"),
            ),
            SizedBox(height: 20),
            Text(message),
          ],
        ),
      ),
    );
  }
}