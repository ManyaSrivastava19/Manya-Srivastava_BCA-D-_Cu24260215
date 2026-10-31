//  Create a Flutter application to pass a student's name from one screen to another screen and display it on the second screen. 
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
            builder: (_) => Page("Mohit"),
          ),
        ),
        child: Text("Next"),
      ),
    ),
  );
}

class Page extends StatelessWidget {
  String name;

  Page(this.name);

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Second Screen")),

    body: Center(
      child: Text(
        "Student: $name",
        style: TextStyle(fontSize: 25),
      ),
    ),
  );
}