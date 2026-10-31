// Create a Flutter application with a Student List Screen and Student Detail Screen. Display the selected student's information on the detail screen. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: StudentList()));

class StudentList extends StatelessWidget {
  final s = ["Mohit", "Rahul", "Aman"];

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Student List")),

    body: Column(
      children: [
        for (var x in s)
          ElevatedButton(
            onPressed: () => Navigator.push(
              c,
              MaterialPageRoute(
                builder: (_) => Detail(x),
              ),
            ),
            child: Text(x),
          ),
      ],
    ),
  );
}

class Detail extends StatelessWidget {
  String n;

  Detail(this.n);

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Student Details")),

    body: Center(
      child: Text(
        "Student: $n",
        style: TextStyle(fontSize: 25),
      ),
    ),
  );
}