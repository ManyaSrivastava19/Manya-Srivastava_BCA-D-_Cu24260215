// Create a Flutter To-Do application whose task list is saved using SharedPreferences and restored when the application is reopened. 
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(home: App()));

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  List<String> t = [];

  // Load saved tasks
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((p) {
      setState(() {
        t = p.getStringList("t") ?? [];
      });
    });
  }

  // Add and save task
  void addTask() async {
    t.add("New Task");

    var p = await SharedPreferences.getInstance();

    await p.setStringList("t", t);

    setState(() {});
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do App")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: addTask,
            child: Text("Add Task"),
          ),
          ...t.map((x) => ListTile(
                leading: Icon(Icons.task),
                title: Text(x),
              )),
        ],
      ),
    );
  }
}