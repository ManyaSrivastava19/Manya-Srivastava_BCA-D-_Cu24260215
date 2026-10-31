//  Create a Flutter application to store and display a list of strings (such as favourite subjects) using SharedPreferences. 
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(home: App()));

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  List<String> subjects = ["Python", "AI", "DBMS"];

  // Save subjects list
  void save() async {
    var p = await SharedPreferences.getInstance();

    await p.setStringList("subjects", subjects);
  }

  // Load saved subjects
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((p) {
      setState(() {
        subjects = p.getStringList("subjects") ??
            ["Python", "AI", "DBMS"];
      });
    });
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text("Favourite Subjects")),
      body: Column(
        children: [
          ...subjects.map((x) => ListTile(
                title: Text(x),
              )),
          ElevatedButton(
            onPressed: save,
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}