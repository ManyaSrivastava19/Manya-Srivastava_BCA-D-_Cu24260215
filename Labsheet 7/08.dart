// Create a Flutter application to update an existing student record using the update() method. 
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

  Future<void> updateStudent() async {
    if (id.text.isEmpty ||
        name.text.isEmpty ||
        roll.text.isEmpty ||
        course.text.isEmpty ||
        int.tryParse(id.text) == null ||
        int.tryParse(roll.text) == null) {
      setState(() {
        message = "Please enter valid details!";
      });
      return;
    }

    Database db = await getDB();

    int result = await db.update(
      'Students',
      {
        'name': name.text,
        'rollNumber': int.parse(roll.text),
        'course': course.text,
      },
      where: 'id = ?',
      whereArgs: [int.parse(id.text)],
    );

    setState(() {
      message = result > 0
          ? "Student Record Updated Successfully!"
          : "Student ID Not Found!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Student Record")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: id,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter Student ID"),
            ),
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
              onPressed: updateStudent,
              child: Text("Update Record"),
            ),
            SizedBox(height: 20),
            Text(message),
          ],
        ),
      ),
    );
  }
}