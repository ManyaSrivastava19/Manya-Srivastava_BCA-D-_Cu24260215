// Create a Flutter application to search for a student by roll number using a WHERE condition. 
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
  final roll = TextEditingController();
  String result = "";

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

  Future<void> searchStudent() async {
    if (int.tryParse(roll.text) == null) {
      setState(() {
        result = "Please enter a valid roll number!";
      });
      return;
    }

    Database db = await getDB();

    List<Map<String, dynamic>> data = await db.query(
      'Students',
      where: 'rollNumber = ?',
      whereArgs: [int.parse(roll.text)],
    );

    setState(() {
      if (data.isNotEmpty) {
        result =
            "Name: ${data[0]['name']}\n"
            "Roll Number: ${data[0]['rollNumber']}\n"
            "Course: ${data[0]['course']}";
      } else {
        result = "Student Not Found!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Student")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: roll,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter Roll Number",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: searchStudent,
              child: Text("Search Student"),
            ),
            SizedBox(height: 20),
            Text(result),
          ],
        ),
      ),
    );
  }
}