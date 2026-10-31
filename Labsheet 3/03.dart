// Create a Flutter application to accept two numbers and perform addition, subtraction, multiplication, and division using buttons. 
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
  double a = 0, b = 0, r = 0;

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (x) => a = double.parse(x),
          ),

          TextField(
            keyboardType: TextInputType.number,
            onChanged: (x) => b = double.parse(x),
          ),

          Row(
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
                onPressed: () => setState(() => r = a / b),
                child: Text("÷"),
              ),
            ],
          ),

          Text("Result: $r"),
        ],
      ),
    );
  }
}