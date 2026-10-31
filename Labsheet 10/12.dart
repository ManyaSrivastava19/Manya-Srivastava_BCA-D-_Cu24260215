Create a Flutter application to display the students of a selected course from Cloud Firestore using the where() query. 
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
      home: CourseStudentScreen(),
    );
  }
}

class CourseStudentScreen extends StatefulWidget {
  @override
  State<CourseStudentScreen> createState() =>
      _CourseStudentScreenState();
}

class _CourseStudentScreenState
    extends State<CourseStudentScreen> {

  String selectedCourse = 'BCA';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students by Course'),
        backgroundColor: Colors.blue,
      ),

      body: Column(
        children: [

          Padding(
            padding: EdgeInsets.all(15),
            child: DropdownButtonFormField<String>(
              value: selectedCourse,
              decoration: InputDecoration(
                labelText: 'Select Course',
                border: OutlineInputBorder(),
              ),

              items: [
                'BCA',
                'BBA',
                'BCA AI & ML',
                'MCA',
              ].map((course) {
                return DropdownMenuItem(
                  value: course,
                  child: Text(course),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  selectedCourse = value!;
                });
              },
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('students')
                  .where('course', isEqualTo: selectedCourse)
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
                    child: Text('Error loading students!'),
                  );
                }

                if (!snapshot.hasData ||
                    snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No students found!'),
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
          ),
        ],
      ),
    );
  }
}