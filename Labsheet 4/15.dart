//  Create a Flutter application with a Home Screen containing buttons for Student  Profile, Attendance, and Result screens. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Student Dashboard")),

    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
        x,
        style: TextStyle(fontSize: 25),
      ),
    ),
  );
}