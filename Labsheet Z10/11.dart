// Create a Flutter application to delete a student record from Cloud Firestore. 
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
      home: DeleteStudentScreen(),
    );
  }
}

class DeleteStudentScreen extends StatefulWidget {
  @override
  State<DeleteStudentScreen> createState() =>
      _DeleteStudentScreenState();
}

class _DeleteStudentScreenState
    extends State<DeleteStudentScreen> {

  final rollController = TextEditingController();

  Future<void> deleteStudent() async {
    String roll = rollController.text.trim();

    if (roll.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter roll number!')),
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

      // Delete student record
      for (var doc in result.docs) {
        await doc.reference.delete();
      }

      rollController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student deleted successfully!')),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting student!')),
      );
    }
  }

  @override
  void dispose() {
    rollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Student Record'),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.delete,
              size: 80,
              color: Colors.red,
            ),

            SizedBox(height: 20),

            TextField(
              controller: rollController,
              decoration: InputDecoration(
                labelText: 'Enter Roll Number',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 25),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: deleteStudent,
              child: Text('Delete Student'),
            ),
          ],
        ),
      ),
    );
  }
}