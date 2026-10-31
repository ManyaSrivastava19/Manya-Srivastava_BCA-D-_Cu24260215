//  Create a Flutter application to accept a student's name using a TextField and display it on the screen. 
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: TextField(
          onChanged: (name) => print(name),
          decoration: InputDecoration(
            labelText: "Enter Name",
          ),
        ),
      ),
    ),
  );
}