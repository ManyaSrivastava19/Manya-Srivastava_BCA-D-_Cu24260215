// Create a Flutter application with a form that accepts a student's name and displays the entered name on a new screen after pressing the Submit button. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  final t = TextEditingController();

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Student Form")),

    body: Padding(
      padding: EdgeInsets.all(20),

      child: Column(
        children: [
          TextField(
            controller: t,
            decoration: InputDecoration(
              labelText: "Enter Student Name",
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: () => Navigator.push(
              c,
              MaterialPageRoute(
                builder: (_) => Page(t.text),
              ),
            ),
            child: Text("Submit"),
          ),
        ],
      ),
    ),
  );
}

class Page extends StatelessWidget {
  String n;

  Page(this.n);

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Student Details")),

    body: Center(
      child: Text(
        "Name: $n",
        style: TextStyle(fontSize: 25),
      ),
    ),
  );
}