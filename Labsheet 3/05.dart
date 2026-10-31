// Create a Flutter application with an ElevatedButton that displays a message using SnackBar. 
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(c).showSnackBar(
              SnackBar(
                content: Text("Button Pressed!"),
              ),
            );
          },
          child: Text("Click Me"),
        ),
      ),
    );
  }
}