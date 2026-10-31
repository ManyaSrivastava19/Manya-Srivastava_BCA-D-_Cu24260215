// Create a Flutter application with a button that changes the displayed text when pressed. 
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
  String text = "Hello";

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: Column(
        children: [
          Text(text),

          ElevatedButton(
            onPressed: () => setState(() => text = "Welcome"),
            child: Text("Change"),
          ),
        ],
      ),
    );
  }
}