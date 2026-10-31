// Create a Flutter application to display the students of a course selected using a DropdownButton.
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
  String course = "BCA";
  List<Map<String, dynamic>> students = [];

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

  Future<void> getStudents() async {
    Database db = await getDB();

    List<Map<String, dynamic>> data = await db.query(
      'Students',
      where: 'course = ?',
      whereArgs: [course],
    );

    setState(() {
      students = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Students by Course")),
      body: Column(
        children: [
          DropdownButton<String>(
            value: course,
            items: ["BCA", "BBA", "MCA"].map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                course = value!;
              });
              getStudents();
            },
          ),
          Expanded(
            child: students.isEmpty
                ? Center(child: Text("No Students Found"))
                : ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      var student = students[index];

                      return ListTile(
                        title: Text(student['name']),
                        subtitle: Text(
                          "Roll No: ${student['rollNumber']} | Course: ${student['course']}",
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