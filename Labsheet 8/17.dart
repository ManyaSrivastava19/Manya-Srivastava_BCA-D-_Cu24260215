// Develop a Student Management Application in Flutter using SQLite containing Home, Add Student, Student List, and Update Student screens with input validation and delete confirmation.
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
      home: HomeScreen(),
    );
  }
}

// DATABASE HELPER
class DBHelper {
  static Database? db;

  static Future<Database> getDB() async {
    if (db != null) return db!;

    String path = join(await getDatabasesPath(), 'student.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            roll TEXT,
            course TEXT
          )
        ''');
      },
    );

    return db!;
  }

  static Future<List<Map<String, dynamic>>> getStudents() async {
    final database = await getDB();
    return database.query('Students', orderBy: 'id DESC');
  }

  static Future<void> insertStudent(Map<String, dynamic> data) async {
    final database = await getDB();
    await database.insert('Students', data);
  }

  static Future<void> updateStudent(
      int id, Map<String, dynamic> data) async {
    final database = await getDB();
    await database.update(
      'Students',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteStudent(int id) async {
    final database = await getDB();
    await database.delete(
      'Students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// HOME SCREEN
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Management')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Student Management System',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddStudentScreen(),
                  ),
                );
              },
              child: const Text('Add Student'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const StudentListScreen(),
                  ),
                );
              },
              child: const Text('Student List'),
            ),
          ],
        ),
      ),
    );
  }
}

// ADD STUDENT SCREEN
class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final roll = TextEditingController();
  final course = TextEditingController();

  Future<void> saveStudent() async {
    if (!formKey.currentState!.validate()) return;

    await DBHelper.insertStudent({
      'name': name.text.trim(),
      'roll': roll.text.trim(),
      'course': course.text.trim(),
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Student Added Successfully')),
    );

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
      appBar: AppBar(title: const Text('Add Student')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Student Name'),
                validator: (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Enter student name'
                        : null,
              ),
              TextFormField(
                controller: roll,
                decoration: const InputDecoration(labelText: 'Roll Number'),
                validator: (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Enter roll number'
                        : null,
              ),
              TextFormField(
                controller: course,
                decoration: const InputDecoration(labelText: 'Course'),
                validator: (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Enter course'
                        : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveStudent,
                child: const Text('Save Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// STUDENT LIST SCREEN
class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<Map<String, dynamic>> students = [];

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  Future<void> loadStudents() async {
    students = await DBHelper.getStudents();
    if (mounted) setState(() {});
  }

  Future<void> confirmDelete(int id) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Student'),
        content: const Text('Are you sure you want to delete this student?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DBHelper.deleteStudent(id);
      loadStudents();
    }
  }

  Future<void> editStudent(Map<String, dynamic> student) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UpdateStudentScreen(student: student),
      ),
    );
    loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student List')),
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
                      'Roll: ${student['roll']}\n'
                      'Course: ${student['course']}',
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => editStudent(student),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => confirmDelete(student['id']),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// UPDATE STUDENT SCREEN
class UpdateStudentScreen extends StatefulWidget {
  final Map<String, dynamic> student;

  const UpdateStudentScreen({super.key, required this.student});

  @override
  State<UpdateStudentScreen> createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController roll;
  late TextEditingController course;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.student['name']);
    roll = TextEditingController(text: widget.student['roll']);
    course = TextEditingController(text: widget.student['course']);
  }

  Future<void> updateStudent() async {
    if (!formKey.currentState!.validate()) return;

    await DBHelper.updateStudent(widget.student['id'], {
      'name': name.text.trim(),
      'roll': roll.text.trim(),
      'course': course.text.trim(),
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
      appBar: AppBar(title: const Text('Update Student')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Student Name'),
                validator: (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Enter student name'
                        : null,
              ),
              TextFormField(
                controller: roll,
                decoration: const InputDecoration(labelText: 'Roll Number'),
                validator: (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Enter roll number'
                        : null,
              ),
              TextFormField(
                controller: course,
                decoration: const InputDecoration(labelText: 'Course'),
                validator: (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Enter course'
                        : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateStudent,
                child: const Text('Update Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}