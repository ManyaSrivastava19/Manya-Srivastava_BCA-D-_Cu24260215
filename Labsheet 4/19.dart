//  Create a Flutter application to pass two numbers from one screen to another and display their sum on the second screen. 
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
            builder: (_) => Page(10, 20),
          ),
        ),
        child: Text("Next"),
      ),
    ),
  );
}

class Page extends StatelessWidget {
  int a, b;

  Page(this.a, this.b);

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Sum")),

    body: Center(
      child: Text(
        "Sum = ${a + b}",
        style: TextStyle(fontSize: 25),
      ),
    ),
  );
}