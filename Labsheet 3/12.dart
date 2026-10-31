 // Create a Flutter application to calculate the area of a rectangle using length and width entered by the user. 
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
  double l = 0, w = 0;

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (v) => l = double.tryParse(v) ?? 0,
          ),

          TextField(
            keyboardType: TextInputType.number,
            onChanged: (v) => w = double.tryParse(v) ?? 0,
          ),

          ElevatedButton(
            onPressed: () => setState(() {}),
            child: Text("Calculate"),
          ),

          Text("Area: ${l * w}"),
        ],
      ),
    );
  }
}