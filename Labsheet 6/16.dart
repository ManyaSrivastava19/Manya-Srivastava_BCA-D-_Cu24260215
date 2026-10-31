//  Create a Flutter Notes application that saves notes to a JSON file in the documents directory and loads them when the application starts. 
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MaterialApp(home: App()));

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  List<String> notes = [];

  // Save notes into JSON file
  void save() async {
    var d = await getApplicationDocumentsDirectory();

    File("${d.path}/notes.json")
        .writeAsString(jsonEncode(notes));
  }

  // Load notes when app starts
  @override
  void initState() {
    super.initState();

    loadNotes();
  }

  void loadNotes() async {
    var d = await getApplicationDocumentsDirectory();
    var f = File("${d.path}/notes.json");

    if (await f.exists()) {
      String data = await f.readAsString();

      setState(() {
        notes = List<String>.from(jsonDecode(data));
      });
    }
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes App")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                notes.add("New Note");
              });
              save();
            },
            child: Text("Add Note"),
          ),

          ...notes.map((x) => ListTile(
                leading: Icon(Icons.note),
                title: Text(x),
              )),
        ],
      ),
    );
  }
}