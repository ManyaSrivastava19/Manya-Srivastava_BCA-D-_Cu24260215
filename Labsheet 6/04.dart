//  Create a Flutter application to save a user’s name using SharedPreferences and display it when the application is reopened. 
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(home: App()));

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  String name = "";
  final t = TextEditingController();

  // Save name
  void save() async {
    var p = await SharedPreferences.getInstance();

    await p.setString("name", t.text);

    setState(() {
      name = t.text;
    });
  }

  // Load saved name when app starts
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((p) {
      setState(() {
        name = p.getString("name") ?? "";
        t.text = name;
      });
    });
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text("Save User Name")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: t,
              decoration: InputDecoration(
                labelText: "Enter Your Name",
              ),
            ),
            ElevatedButton(
              onPressed: save,
              child: Text("Save"),
            ),
            Text("Saved Name: $name"),
          ],
        ),
      ),
    );
  }
}