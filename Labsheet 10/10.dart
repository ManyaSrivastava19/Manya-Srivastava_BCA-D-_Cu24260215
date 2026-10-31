// Create a Flutter application to update an existing student record in Cloud Firestore. 
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
      home: UpdateStudentScreen(),
    );
  }
}

class UpdateStudentScreen extends StatefulWidget {
  @override
  State<UpdateStudentScreen> createState() =>
      _UpdateStudentScreenState();
}

class _UpdateStudentScreenState
    extends State<UpdateStudentScreen> {

  final rollController = TextEditingController();
  final nameController = TextEditingController();
  final courseController = TextEditingController();

  Future<void> updateStudent() async {
    String roll = rollController.text.trim();
    String name = nameController.text.trim();
    String course = courseController.text.trim();

    if (roll.isEmpty || name.isEmpty || course.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields!')),
      );
      return;
    }

    try {
      var result = await FirebaseFirestore.instance
          .collection('students')
          .where('rollNumber', isEqualTo: roll)
          .get();

      if (result.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Student not found!')),
        );
        return;
      }

      await result.docs.first.reference.update({
        'name': name,
        'course': course,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student updated successfully!')),
      );

      rollController.clear();
      nameController.clear();
      courseController.clear();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating student!')),
      );
    }
  }

  @override
  void dispose() {
    rollController.dispose();
    nameController.dispose();
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Student Record'),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              controller: rollController,
              decoration: InputDecoration(
                labelText: 'Enter Roll Number',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'New Student Name',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: courseController,
              decoration: InputDecoration(
                labelText: 'New Course',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 25),

            ElevatedButton(
              onPressed: updateStudent,
              child: Text('Update Student'),
            ),
          ],
        ),
      ),
    );
  }
}