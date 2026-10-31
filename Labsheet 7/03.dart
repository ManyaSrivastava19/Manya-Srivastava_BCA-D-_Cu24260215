// Create a Flutter application to insert a student record into the students table using the insert() method.
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
    Database db = await getDB();

    await db.insert('Students', {
      'name': name.text,
      'rollNumber': int.parse(roll.text),
      'course': course.text,
    });

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
              decoration: InputDecoration(labelText: "Student Name"),
            ),
            TextField(
              controller: roll,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Roll Number"),
            ),
            TextField(
              controller: course,
              decoration: InputDecoration(labelText: "Course"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: insertStudent,
              child: Text("Insert Student"),
            ),
            SizedBox(height: 20),
            Text(message),
          ],
        ),
      ),
    );
  }
}