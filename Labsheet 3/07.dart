//  Create a Flutter application to accept a student's name and marks in three subjects and display the total marks. 
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
  TextEditingController name = TextEditingController();
  TextEditingController m1 = TextEditingController();
  TextEditingController m2 = TextEditingController();
  TextEditingController m3 = TextEditingController();

  int total = 0;

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: name,
            decoration: InputDecoration(hintText: "Name"),
          ),

          TextField(
            controller: m1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Marks 1"),
          ),

          TextField(
            controller: m2,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Marks 2"),
          ),

          TextField(
            controller: m3,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Marks 3"),
          ),

          ElevatedButton(
            onPressed: () {
              setState(() {
                total = int.parse(m1.text) +
                    int.parse(m2.text) +
                    int.parse(m3.text);
              });
            },
            child: Text("Calculate Total"),
          ),

          Text("Student Name: ${name.text}"),
          Text("Total Marks: $total"),
        ],
      ),
    );
  }
}