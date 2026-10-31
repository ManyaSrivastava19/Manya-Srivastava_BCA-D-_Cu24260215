// Create a Flutter application to create an SQLite database using the sqflite package and display a message when the database is created successfully. 
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
  String message = "Click to Create Database";

  Future<void> createDatabase() async {
    String dbPath = join(await getDatabasesPath(), 'student.db');

    await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE Student(id INTEGER PRIMARY KEY, name TEXT)',
        );
      },
    );

    setState(() {
      message = "Database Created Successfully!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SQLite Database")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: createDatabase,
              child: Text("Create Database"),
            ),
            SizedBox(height: 20),
            Text(message),
          ],
        ),
      ),
    );
  }
}