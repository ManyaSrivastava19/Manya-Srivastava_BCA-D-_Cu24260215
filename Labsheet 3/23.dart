// Create a Flutter Student Feedback Form with name, rating options, feedback field, and Submit button. 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: MyApp()),
);

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _S();
}

class _S extends State<MyApp> {
  int rating = 5;

  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Student Feedback Form")),
    body: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Name"),
          ),

          SizedBox(height: 15),

          Text("Rating"),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (i) => IconButton(
                icon: Icon(
                  Icons.star,
                  color: i < rating ? Colors.orange : Colors.grey,
                ),
                onPressed: () => setState(() => rating = i + 1),
              ),
            ),
          ),

          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              labelText: "Feedback",
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(c).showSnackBar(
                SnackBar(content: Text("Feedback Submitted")),
              );
            },
            child: Text("Submit"),
          ),
        ],
      ),
    ),
  );
}