//  Create a Flutter application with Submit and Reset buttons for a simple form. 
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
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: "Name",
            ),
          ),

          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(c).showSnackBar(
                    SnackBar(content: Text("Form Submitted!")),
                  );
                },
                child: Text("Submit"),
              ),

              ElevatedButton(
                onPressed: () {
                  nameController.clear();
                },
                child: Text("Reset"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}