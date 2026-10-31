// Create a Flutter application containing Checkbox, Radio, DropdownButton, and Switch widgets. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _S();
}

class _S extends State<MyApp> {
  bool c = false, s = false;
  String r = "Male", d = "BCA";

  Widget build(BuildContext x) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: c,
            onChanged: (v) => setState(() => c = v!),
          ),

          Radio<String>(
            value: "Male",
            groupValue: r,
            onChanged: (v) => setState(() => r = v!),
          ),

          DropdownButton<String>(
            value: d,
            items: ["BCA", "BBA", "MCA"]
                .map((x) => DropdownMenuItem<String>(
                      value: x,
                      child: Text(x),
                    ))
                .toList(),
            onChanged: (v) => setState(() => d = v!),
          ),

          Switch(
            value: s,
            onChanged: (v) => setState(() => s = v),
          ),
        ],
      ),
    ),
  );
}