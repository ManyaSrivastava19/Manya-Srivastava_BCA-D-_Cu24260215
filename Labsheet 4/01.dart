//  Create a Flutter application with two screens and navigate from the first screen to the second screen using an ElevatedButton. 
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
        child: Text("Go to Second Screen"),
      ),
    ),
  );
}

class Second extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Second Screen")),
    body: Center(
      child: Text("Second Screen"),
    ),
  );
}