// Create a Flutter application to display student records from Cloud Firestore in ascending order of name using orderBy(). 
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
      home: StudentListScreen(),
    );
  }
}

class StudentListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students by Name'),
        backgroundColor: Colors.blue,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('students')
            .orderBy('name', descending: false)
            .snapshots(),

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error loading student records!'),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No student records found!'),
            );
          }

          var students = snapshot.data!.docs;

          return ListView.builder(
            itemCount: students.length,

            itemBuilder: (context, index) {
              var student = students[index].data()
                  as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.all(10),

                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      (student['name'] ?? '?')[0]
                          .toString()
                          .toUpperCase(),
                    ),
                  ),

                  title: Text(
                    student['name'] ?? 'No Name',
                  ),

                  subtitle: Text(
                    'Roll No: ${student['rollNumber'] ?? ''}\n'
                    'Course: ${student['course'] ?? ''}',
                  ),

                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}