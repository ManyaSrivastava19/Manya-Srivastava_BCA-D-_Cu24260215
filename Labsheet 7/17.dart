// Develop a Student Record Management Application in Flutter using SQLite that allows the user to add, view, update, and delete student records using a Student model class and a DatabaseHelper class.
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Student Model Class
class Student {
  int? id;
  String name;
  int roll;
  String course;

  Student({
    this.id,
    required this.name,
    required this.roll,
    required this.course,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'roll': roll,
      'course': course,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      roll: map['roll'],
      course: map['course'],
    );
  }
}

// Database Helper Class
class DatabaseHelper {
  static Database? db;

  Future<Database> getDB() async {
    if (db != null) return db!;

    String path = join(await getDatabasesPath(), 'student.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) async {
        await database.execute('''
          CREATE TABLE Students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            roll INTEGER,
            course TEXT
          )
        ''');
      },
    );

    return db!;
  }

  // Insert
  Future<int> insertStudent(Student s) async {
    Database database = await getDB();
    return await database.insert('Students', s.toMap());
  }

  // Read
  Future<List<Student>> getStudents() async {
    Database database = await getDB();

    List<Map<String, dynamic>> data =
        await database.query('Students');

    return data.map((e) => Student.fromMap(e)).toList();
  }

  // Update
  Future<int> updateStudent(Student s) async {
    Database database = await getDB();

    return await database.update(
      'Students',
      s.toMap(),
      where: 'id = ?',
      whereArgs: [s.id],
    );
  }

  // Delete
  Future<int> deleteStudent(int id) async {
    Database database = await getDB();

    return await database.delete(
      'Students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// Main Application
void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final helper = DatabaseHelper();

  final name = TextEditingController();
  final roll = TextEditingController();
  final course = TextEditingController();

  List<Student> students = [];
  int? editId;

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  // Display Records
  Future<void> loadStudents() async {
    List<Student> data = await helper.getStudents();

    setState(() {
      students = data;
    });
  }

  // Add or Update Student
  Future<void> saveStudent() async {
    if (name.text.trim().isEmpty ||
        int.tryParse(roll.text) == null ||
        course.text.trim().isEmpty) {
      return;
    }

    Student s = Student(
      id: editId,
      name: name.text.trim(),
      roll: int.parse(roll.text),
      course: course.text.trim(),
    );

    if (editId == null) {
      await helper.insertStudent(s);
    } else {
      await helper.updateStudent(s);
    }

    name.clear();
    roll.clear();
    course.clear();

    setState(() {
      editId = null;
    });

    loadStudents();
  }

  // Edit Student
  void editStudent(Student s) {
    name.text = s.name;
    roll.text = s.roll.toString();
    course.text = s.course;

    setState(() {
      editId = s.id;
    });
  }

  // Delete Student
  Future<void> removeStudent(int id) async {
    await helper.deleteStudent(id);
    loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Record Management"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                labelText: "Enter Name",
              ),
            ),
            TextField(
              controller: roll,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter Roll Number",
              ),
            ),
            TextField(
              controller: course,
              decoration: InputDecoration(
                labelText: "Enter Course",
              ),
            ),
            SizedBox(height: 15),

            ElevatedButton(
              onPressed: saveStudent,
              child: Text(
                editId == null ? "Add Student" : "Update Student",
              ),
            ),

            Divider(),

            Text(
              "Student Records",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Expanded(
              child: students.isEmpty
                  ? Center(child: Text("No Records Found"))
                  : ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        Student s = students[index];

                        return Card(
                          child: ListTile(
                            title: Text(s.name),
                            subtitle: Text(
                              "Roll: ${s.roll} | Course: ${s.course}",
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => editStudent(s),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => removeStudent(s.id!),
                                ),
                              ],
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