// Create a Flutter application to add a student record (name, roll number, and course) to a Cloud Firestore collection. 
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentScreen(),
    );
  }
}

class StudentScreen extends StatefulWidget {
  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final nameController = TextEditingController();
  final rollController = TextEditingController();
  final courseController = TextEditingController();

  Future<void> addStudent() async {
    String name = nameController.text.trim();
    String roll = rollController.text.trim();
    String course = courseController.text.trim();

    if (name.isEmpty || roll.isEmpty || course.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields!')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('students')
          .add({
        'name': name,
        'rollNumber': roll,
        'course': course,
      });

      nameController.clear();
      rollController.clear();
      courseController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding student!')),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    rollController.dispose();
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student Record'),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Student Name',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: rollController,
              decoration: InputDecoration(
                labelText: 'Roll Number',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: courseController,
              decoration: InputDecoration(
                labelText: 'Course',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 25),

            ElevatedButton(
              onPressed: addStudent,
              child: Text('Add Student'),
            ),
          ],
        ),
      ),
    );
  }
}