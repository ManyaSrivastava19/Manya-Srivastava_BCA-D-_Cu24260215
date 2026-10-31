//  Develop a Student Profile Application in Flutter that accepts and saves student details (name, roll number, course, and semester) using SharedPreferences, displays the saved profile when the application is reopened, and allows the user to edit or clear it. 
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(home: App()));

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  final n = TextEditingController();
  final r = TextEditingController();
  final c = TextEditingController();
  final s = TextEditingController();

  String p = "No Profile";

  // Load saved profile
  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  void loadProfile() async {
    var x = await SharedPreferences.getInstance();

    setState(() {
      n.text = x.getString("name") ?? "";
      r.text = x.getString("roll") ?? "";
      c.text = x.getString("course") ?? "";
      s.text = x.getString("semester") ?? "";

      if (n.text.isNotEmpty) {
        p = "${n.text} | ${r.text} | ${c.text} | ${s.text}";
      }
    });
  }

  // Save or edit profile
  void save() async {
    var x = await SharedPreferences.getInstance();

    await x.setString("name", n.text);
    await x.setString("roll", r.text);
    await x.setString("course", c.text);
    await x.setString("semester", s.text);

    setState(() {
      p = "${n.text} | ${r.text} | ${c.text} | ${s.text}";
    });
  }

  // Clear profile
  void clear() async {
    var x = await SharedPreferences.getInstance();

    await x.remove("name");
    await x.remove("roll");
    await x.remove("course");
    await x.remove("semester");

    setState(() {
      n.clear();
      r.clear();
      c.clear();
      s.clear();
      p = "No Profile";
    });
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Profile")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: n,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: r,
                decoration: InputDecoration(labelText: "Roll Number"),
              ),
              TextField(
                controller: c,
                decoration: InputDecoration(labelText: "Course"),
              ),
              TextField(
                controller: s,
                decoration: InputDecoration(labelText: "Semester"),
              ),
              SizedBox(height: 15),

              ElevatedButton(
                onPressed: save,
                child: Text("Save / Edit"),
              ),

              ElevatedButton(
                onPressed: clear,
                child: Text("Clear Profile"),
              ),

              SizedBox(height: 20),
              Text(
                "Saved Profile:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(p),
            ],
          ),
        ),
      ),
    );
  }
}