// Create a Flutter application to convert Celsius temperature into Fahrenheit using user input. 
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
  double c = 0;

  @override
  Widget build(BuildContext x) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (v) => c = double.tryParse(v) ?? 0,
          ),

          ElevatedButton(
            onPressed: () => setState(() {}),
            child: Text("Convert"),
          ),

          Text("Fahrenheit: ${c * 9 / 5 + 32}"),
        ],
      ),
    );
  }
}