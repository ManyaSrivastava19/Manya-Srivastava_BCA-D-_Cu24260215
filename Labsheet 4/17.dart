// Create a Flutter application to pass a student's name and course from the first screen to then second screen. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Home Screen")),

    body: Center(
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          c,
          MaterialPageRoute(
            builder: (_) => Page("Mohit", "BCA"),
          ),
        ),
        child: Text("Next"),
      ),
    ),
  );
}

class Page extends StatelessWidget {
  String n, co;

  Page(this.n, this.co);

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Student Details")),

    body: Center(
      child: Text(
        "$n - $co",
        style: TextStyle(fontSize: 25),
      ),
    ),
  );
}