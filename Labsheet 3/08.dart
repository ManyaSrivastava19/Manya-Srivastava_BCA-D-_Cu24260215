// Create a Flutter application to calculate percentage from three subject marks entered by the user. 
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
  var a = 0, b = 0, c = 0;

  @override
  Widget build(BuildContext x) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (v) => a = int.parse(v),
          ),

          TextField(
            keyboardType: TextInputType.number,
            onChanged: (v) => b = int.parse(v),
          ),

          TextField(
            keyboardType: TextInputType.number,
            onChanged: (v) => c = int.parse(v),
          ),

          ElevatedButton(
            onPressed: () => setState(() {}),
            child: Text("Calculate"),
          ),

          Text("Percentage: ${(a + b + c) / 3}%"),
        ],
      ),
    );
  }
}