//  Create a Flutter application with a Checkbox to select whether the user agrees to the terms and conditions. 
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
  bool agree = false;

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: Row(
        children: [
          Checkbox(
            value: agree,
            onChanged: (v) => setState(() => agree = v!),
          ),

          Text("I agree to Terms & Conditions"),
        ],
      ),
    );
  }
}