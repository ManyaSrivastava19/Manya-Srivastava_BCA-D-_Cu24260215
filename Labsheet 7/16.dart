// Create a DatabaseHelper class to perform all database operations (open, insert, read, update, and delete) in a Flutter application.
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Database Helper Class
class DatabaseHelper {
  static Database? database;

  // Open Database
  Future<Database> getDB() async {
    if (database != null) return database!;

    String path = join(await getDatabasesPath(), 'student.db');

    database = await openDatabase(
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

    return database!;
  }

  // Insert Record
  Future<int> insertStudent(Map<String, dynamic> data) async {
    Database db = await getDB();
    return await db.insert('Students', data);
  }

  // Read Records
  Future<List<Map<String, dynamic>>> readStudents() async {
    Database db = await getDB();
    return await db.query('Students');
  }

  // Update Record
  Future<int> updateStudent(
      int id, Map<String, dynamic> data) async {
    Database db = await getDB();

    return await db.update(
      'Students',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete Record
  Future<int> deleteStudent(int id) async {
    Database db = await getDB();

    return await db.delete(
      'Students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final dbHelper = DatabaseHelper();

  List<Map<String, dynamic>> students = [];
  String message = "";

  // Insert Example Record
  Future<void> insertData() async {
    await dbHelper.insertStudent({
      'name': 'Mohit',
      'rollNumber': 101,
      'course': 'BCA',
    });

    setState(() {
      message = "Student Inserted Successfully!";
    });

    readData();
  }

  // Read Records
  Future<void> readData() async {
    List<Map<String, dynamic>> data =
        await dbHelper.readStudents();

    setState(() {
      students = data;
    });
  }

  // Update First Record
  Future<void> updateData() async {
    if (students.isEmpty) {
      await readData();
    }

    if (students.isEmpty) return;

    await dbHelper.updateStudent(students[0]['id'], {
      'name': 'Rahul',
      'rollNumber': 102,
      'course': 'BCA',
    });

    setState(() {
      message = "Student Updated Successfully!";
    });

    readData();
  }

  // Delete First Record
  Future<void> deleteData() async {
    if (students.isEmpty) {
      await readData();
    }

    if (students.isEmpty) return;

    await dbHelper.deleteStudent(students[0]['id']);

    setState(() {
      message = "Student Deleted Successfully!";
    });

    readData();
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Database Helper")),
      body: Column(
        children: [
          Wrap(
            spacing: 8,
            children: [
              ElevatedButton(
                onPressed: insertData,
                child: Text("Insert"),
              ),
              ElevatedButton(
                onPressed: readData,
                child: Text("Read"),
              ),
              ElevatedButton(
                onPressed: updateData,
                child: Text("Update"),
              ),
              ElevatedButton(
                onPressed: deleteData,
                child: Text("Delete"),
              ),
            ],
          ),
          Text(message),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                var s = students[index];

                return ListTile(
                  title: Text(s['name']),
                  subtitle: Text(
                    "Roll No: ${s['rollNumber']} | Course: ${s['course']}",
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}