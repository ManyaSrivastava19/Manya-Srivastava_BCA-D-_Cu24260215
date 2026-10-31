//  Create a Flutter application to accept two numbers using TextField and display their sum. 
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
            ),
            TextField(
              keyboardType: TextInputType.number,
            ),
            Text("Sum will be shown here"),
          ],
        ),
      ),
    ),
  );
}