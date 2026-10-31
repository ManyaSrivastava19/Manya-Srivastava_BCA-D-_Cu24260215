// Create a Flutter application to calculate BMI using height and weight entered by the user. 
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
  double h = 0, w = 0;

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (v) => h = double.tryParse(v) ?? 0,
            decoration: InputDecoration(
              labelText: "Height (m)",
            ),
          ),

          TextField(
            keyboardType: TextInputType.number,
            onChanged: (v) => w = double.tryParse(v) ?? 0,
            decoration: InputDecoration(
              labelText: "Weight (kg)",
            ),
          ),

          ElevatedButton(
            onPressed: () => setState(() {}),
            child: Text("Calculate"),
          ),

          Text("BMI = Weight / (Height × Height)"),

          Text(
            "BMI: ${h > 0 ? (w / (h * h)).toStringAsFixed(2) : 0}",
          ),
        ],
      ),
    );
  }
}