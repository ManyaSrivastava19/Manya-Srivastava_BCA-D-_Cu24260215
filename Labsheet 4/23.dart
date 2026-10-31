//  Create a Flutter application for a simple college app containing Home, Courses, Faculty, and Contact screens using navigation. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("College App")),

    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var x in ["Courses", "Faculty", "Contact"])
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
        "$x Screen",
        style: TextStyle(fontSize: 25),
      ),
    ),
  );
}