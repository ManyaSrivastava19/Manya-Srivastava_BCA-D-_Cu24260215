// Create a Flutter application with a Student List screen and an Add/Edit Student screen connected using Navigator and an SQLite database.
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentList(),
    );
  }
}

class StudentDB {
  static Database? db;

  static Future<Database> getDatabase() async {
    if (db != null) return db!;

    String path = join(await getDatabasesPath(), 'student.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE Students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            rollNumber TEXT,
            course TEXT
          )
        ''');
      },
    );

    return db!;
  }

  static Future<List<Map<String, dynamic>>> getStudents() async {
    final database = await getDatabase();
    return database.query('Students', orderBy: 'id DESC');
  }

  static Future<void> saveStudent(Map<String, dynamic> data) async {
    final database = await getDatabase();

    if (data['id'] == null) {
      await database.insert('Students', data);
    } else {
      await database.update(
        'Students',
        data,
        where: 'id = ?',
        whereArgs: [data['id']],
      );
    }
  }

  static Future<void> deleteStudent(int id) async {
    final database = await getDatabase();
    await database.delete(
      'Students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// Student List Screen
class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  List<Map<String, dynamic>> students = [];

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  Future<void> loadStudents() async {
    students = await StudentDB.getStudents();
    setState(() {});
  }

  Future<void> openForm([Map<String, dynamic>? student]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditStudent(student: student),
      ),
    );
    loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        backgroundColor: Colors.blue,
      ),
      body: students.isEmpty
          ? const Center(child: Text('No Students Found'))
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];

                return Card(
                  child: ListTile(
                    title: Text(student['name']),
                    subtitle: Text(
                      'Roll No: ${student['rollNumber']}\n'
                      'Course: ${student['course']}',
                    ),
                    isThreeLine: true,
                    onTap: () => openForm(student),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await StudentDB.deleteStudent(student['id']);
                        loadStudents();
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Add / Edit Student Screen
class AddEditStudent extends StatefulWidget {
  final Map<String, dynamic>? student;

  const AddEditStudent({super.key, this.student});

  @override
  State<AddEditStudent> createState() => _AddEditStudentState();
}

class _AddEditStudentState extends State<AddEditStudent> {
  final name = TextEditingController();
  final roll = TextEditingController();
  final course = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.student != null) {
      name.text = widget.student!['name'];
      roll.text = widget.student!['rollNumber'];
      course.text = widget.student!['course'];
    }
  }

  Future<void> save() async {
    if (name.text.isEmpty ||
        roll.text.isEmpty ||
        course.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    await StudentDB.saveStudent({
      if (widget.student != null) 'id': widget.student!['id'],
      'name': name.text,
      'rollNumber': roll.text,
      'course': course.text,
    });

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  void dispose() {
    name.dispose();
    roll.dispose();
    course.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null
            ? 'Add Student'
            : 'Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Student Name'),
            ),
            TextField(
              controller: roll,
              decoration: const InputDecoration(labelText: 'Roll Number'),
            ),
            TextField(
              controller: course,
              decoration: const InputDecoration(labelText: 'Course'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: save,
              child: const Text('Save Student'),
            ),
          ],
        ),
      ),
    );
  }
}