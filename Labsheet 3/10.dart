// . Create a Flutter application to check whether a number entered by the user is positive, negative, or zero. 
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
  int n = 0;

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (v) => n = int.tryParse(v) ?? 0,
          ),

          ElevatedButton(
            onPressed: () => setState(() {}),
            child: Text("Check"),
          ),

          Text(
            n > 0
                ? "Positive"
                : n < 0
                    ? "Negative"
                    : "Zero",
          ),
        ],
      ),
    );
  }
}