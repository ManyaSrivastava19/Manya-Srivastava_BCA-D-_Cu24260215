//  Develop a Student Management Application in Flutter containing Home, Student Profile, Attendance, and Result screens. Implement navigation between all screens and display basic student information on the respective screens. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Student Management")),

    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome to Student Management App",
            style: TextStyle(fontSize: 18),
          ),

          SizedBox(height: 20),

          for (var x in ["Profile", "Attendance", "Result"])
            ElevatedButton(
              onPressed: () => Navigator.push(
                c,
                MaterialPageRoute(
                  builder: (_) => Page(x),
                ),
              ),
              child: Text(x),
            ),
        ],
      ),
    ),
  );
}

class Page extends StatelessWidget {
  String x;

  Page(this.x);

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text(x)),

    body: Center(
      child: Text(
        x == "Profile"
            ? "Name: Mohit\nCourse: BCA"
            : x == "Attendance"
                ? "Attendance: 85%"
                : "Result: PASS",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
      ),
    ),
  );
}