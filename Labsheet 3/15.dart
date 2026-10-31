// . Create a Flutter application using Radio buttons to select the student's gender. 
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
  String g = "Male";

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: Column(
        children: [
          Radio<String>(
            value: "Male",
            groupValue: g,
            onChanged: (v) => setState(() => g = v!),
          ),

          Radio<String>(
            value: "Female",
            groupValue: g,
            onChanged: (v) => setState(() => g = v!),
          ),

          Text(g),
        ],
      ),
    );
  }
}