// Create a Flutter application using a DropdownButton to select a semester. 
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _S();
}

class _S extends State<MyApp> {
  String s = "Semester 1";

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: DropdownButton<String>(
        value: s,

        items: [
          "Semester 1",
          "Semester 2",
          "Semester 3",
          "Semester 4"
        ].map(
          (x) => DropdownMenuItem<String>(
            value: x,
            child: Text(x),
          ),
        ).toList(),

        onChanged: (v) => setState(() => s = v!),
      ),
    );
  }
}