// Create a Flutter application to check whether a number entered by the user is even or odd. 
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
  int num = 0;
  String result = "Even / Odd";

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (v) => num = int.parse(v),
          ),

          ElevatedButton(
            onPressed: () {
              setState(() {
                if (num % 2 == 0) {
                  result = "Even Number";
                } else {
                  result = "Odd Number";
                }
              });
            },
            child: Text("Check"),
          ),

          Text(result),
        ],
      ),
    );
  }
}