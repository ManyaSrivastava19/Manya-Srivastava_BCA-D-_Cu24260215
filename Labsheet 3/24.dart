//  Create a Flutter Simple Calculator that accepts two numbers and performs operations using buttons. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _S();
}

class _S extends State<MyApp> {
  double a = 0, b = 0, r = 0;

  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Simple Calculator")),
    body: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Enter First Number"),
            onChanged: (v) => a = double.tryParse(v) ?? 0,
          ),

          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Enter Second Number"),
            onChanged: (v) => b = double.tryParse(v) ?? 0,
          ),

          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => setState(() => r = a + b),
                child: Text("+"),
              ),

              ElevatedButton(
                onPressed: () => setState(() => r = a - b),
                child: Text("-"),
              ),

              ElevatedButton(
                onPressed: () => setState(() => r = a * b),
                child: Text("×"),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    r = b != 0 ? a / b : 0;
                  });
                },
                child: Text("÷"),
              ),
            ],
          ),

          SizedBox(height: 20),

          Text(
            "Result: $r",
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    ),
  );
}