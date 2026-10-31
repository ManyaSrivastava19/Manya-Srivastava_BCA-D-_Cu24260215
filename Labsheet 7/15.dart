// Create a Dart model class Student with toMap() and fromMap() methods and use it to insert and retrieve records from the SQLite database. 
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Student Model Class
class Student {
  int? id;
  String name;
  int rollNumber;
  String course;

  Student({
    this.id,
    required this.name,
    required this.rollNumber,
    required this.course,
  });

  // Convert Student object into Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rollNumber': rollNumber,
      'course': course,
    };
  }

  // Convert Map into Student object
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      rollNumber: map['rollNumber'],
      course: map['course'],
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
  final name = TextEditingController();
  final roll = TextEditingController();
  final course = TextEditingController();

  List<Student> students = [];

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

  // Insert Student Record
  Future<void> insertStudent() async {
    if (name.text.trim().isEmpty ||
        int.tryParse(roll.text) == null ||
        course.text.trim().isEmpty) {
      return;
    }

    Database db = await getDB();

    Student student = Student(
      name: name.text.trim(),
      rollNumber: int.parse(roll.text),
      course: course.text.trim(),
    );

    await db.insert('Students', student.toMap());

    name.clear();
    roll.clear();
    course.clear();

    getStudents();
  }

  // Retrieve Student Records
  Future<void> getStudents() async {
    Database db = await getDB();

    List<Map<String, dynamic>> data =
        await db.query('Students');

    setState(() {
      students = data.map((e) => Student.fromMap(e)).toList();
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
      appBar: AppBar(title: Text("Student Database")),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(labelText: "Enter Name"),
            ),
            TextField(
              controller: roll,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Roll Number"),
            ),
            TextField(
              controller: course,
              decoration: InputDecoration(labelText: "Enter Course"),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: insertStudent,
              child: Text("Insert Student"),
            ),
            ElevatedButton(
              onPressed: getStudents,
              child: Text("Display Students"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  Student s = students[index];

                  return ListTile(
                    title: Text(s.name),
                    subtitle: Text(
                      "Roll No: ${s.rollNumber} | Course: ${s.course}",
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