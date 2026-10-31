//  Create a Flutter application to save a Student object as a JSON string in SharedPreferences and display it after retrieving it. 
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(home: App()));

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  String s = "";

  // Save Student object as JSON
  void save() async {
    var p = await SharedPreferences.getInstance();

    String json = jsonEncode({
      "name": "Mohit",
      "age": 20
    });

    await p.setString("student", json);

    setState(() {
      s = "Mohit, Age: 20";
    });
  }

  // Retrieve and decode JSON
  void retrieve() async {
    var p = await SharedPreferences.getInstance();

    String? json = p.getString("student");

    if (json != null) {
      var data = jsonDecode(json);

      setState(() {
        s = "${data["name"]}, Age: ${data["age"]}";
      });
    }
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Details")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: save,
              child: Text("Save"),
            ),
            ElevatedButton(
              onPressed: retrieve,
              child: Text("Retrieve"),
            ),
            Text(s),
          ],
        ),
      ),
    );
  }
}