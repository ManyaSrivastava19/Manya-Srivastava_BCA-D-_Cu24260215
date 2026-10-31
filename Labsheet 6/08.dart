//  Create a Flutter application to save and display multiple values (name, email, and age) using SharedPreferences. 
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(home: App()));

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  String n = "", e = "", a = "";

  // Save user details
  void save() async {
    var p = await SharedPreferences.getInstance();

    await p.setString("name", n);
    await p.setString("email", e);
    await p.setString("age", a);

    setState(() {});
  }

  // Load saved details
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((p) {
      setState(() {
        n = p.getString("name") ?? "";
        e = p.getString("email") ?? "";
        a = p.getString("age") ?? "";
      });
    });
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Enter Name"),
              onChanged: (v) => n = v,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Enter Email"),
              onChanged: (v) => e = v,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Enter Age"),
              keyboardType: TextInputType.number,
              onChanged: (v) => a = v,
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: save,
              child: Text("Save"),
            ),
            SizedBox(height: 15),
            Text("Name: $n"),
            Text("Email: $e"),
            Text("Age: $a"),
          ],
        ),
      ),
    );
  }
}