//  Develop a Student Result Application in Flutter that accepts student name and marks in three subjects, calculates total and percentage, and displays Pass/Fail. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _S();
}

class _S extends State<MyApp> {
  String n = "";
  int a = 0, b = 0, c = 0;

  Widget build(BuildContext x) {
    int total = a + b + c;
    double per = total / 3;

    return Scaffold(
      appBar: AppBar(title: Text("Student Result")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Student Name"),
              onChanged: (v) => n = v,
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Subject 1 Marks"),
              onChanged: (v) => a = int.tryParse(v) ?? 0,
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Subject 2 Marks"),
              onChanged: (v) => b = int.tryParse(v) ?? 0,
            ),

            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Subject 3 Marks"),
              onChanged: (v) => c = int.tryParse(v) ?? 0,
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => setState(() {}),
              child: Text("Result"),
            ),

            SizedBox(height: 15),

            Text("Student Name: $n"),
            Text("Total = $total"),
            Text("Percentage = ${per.toStringAsFixed(2)}%"),
            Text(
              per >= 40 ? "PASS" : "FAIL",
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}