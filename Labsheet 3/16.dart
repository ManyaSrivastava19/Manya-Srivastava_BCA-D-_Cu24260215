// Create a Flutter application using Radio buttons to select a course from three options. 
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
  String c = "BCA";

  @override
  Widget build(BuildContext x) {
    return Scaffold(
      body: Column(
        children: [
          for (var i in ["BCA", "BBA", "MCA"])
            Radio<String>(
              value: i,
              groupValue: c,
              onChanged: (v) => setState(() => c = v!),
            ),

          Text("Course: $c"),
        ],
      ),
    );
  }
}