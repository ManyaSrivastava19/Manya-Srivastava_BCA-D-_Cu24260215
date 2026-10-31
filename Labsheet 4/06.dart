// Create a Flutter application to navigate to a new screen using Navigator.push(). 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: First()),
);

class First extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("First Screen")),
    body: Center(
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          c,
          MaterialPageRoute(builder: (_) => Second()),
        ),
        child: Text("Next"),
      ),
    ),
  );
}

class Second extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Second Screen")),
    body: Center(
      child: Text("New Screen"),
    ),
  );
}