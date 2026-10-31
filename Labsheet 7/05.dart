// Create a Flutter application to insert a student record using the rawInsert() method. 
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
  final name = TextEditingController();
  final roll = TextEditingController();
  final course = TextEditingController();

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

  Future<void> insertStudent() async {
    if (name.text.trim().isEmpty ||
        roll.text.trim().isEmpty ||
        course.text.trim().isEmpty ||
        int.tryParse(roll.text) == null) {
      setState(() {
        message = "Please enter valid details!";
      });
      return;
    }

    Database db = await getDB();

    await db.rawInsert(
      'INSERT INTO Students(name, rollNumber, course) VALUES(?, ?, ?)',
      [name.text.trim(), int.parse(roll.text), course.text.trim()],
    );

    setState(() {
      message = "Student Record Inserted Successfully!";
    });

    name.clear();
    roll.clear();
    course.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Insert Student Record")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(labelText: "Enter Name"),
            ),
            TextField(
              controller: roll,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter Roll Number"),
            ),
            TextField(
              controller: course,
              decoration: InputDecoration(labelText: "Enter Course"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: insertStudent,
              child: Text("Insert Record"),
            ),
            SizedBox(height: 20),
            Text(message),
          ],
        ),
      ),
    );
  }
}