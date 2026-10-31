// Create a Flutter application using a DropdownButton to select a department. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _S();
}

class _S extends State<MyApp> {
  String d = "Computer Science";

  Widget build(BuildContext c) => Scaffold(
    body: Center(
      child: DropdownButton<String>(
        value: d,
        items: ["Computer Science", "BCA", "BBA"]
            .map((x) => DropdownMenuItem<String>(
                  value: x,
                  child: Text(x),
                ))
            .toList(),
        onChanged: (v) => setState(() => d = v!),
      ),
    ),
  );
}