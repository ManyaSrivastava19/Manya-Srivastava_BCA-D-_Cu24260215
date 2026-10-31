//  Create a Flutter Registration Form UI with name, email, password, gender, course, and Register button. 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: MyApp()),
);

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _S();
}

class _S extends State<MyApp> {
  String gender = "Male";
  String course = "BCA";

  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Registration Form")),
    body: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Name"),
          ),

          TextField(
            decoration: InputDecoration(labelText: "Email"),
          ),

          TextField(
            obscureText: true,
            decoration: InputDecoration(labelText: "Password"),
          ),

          SizedBox(height: 10),

          Text("Gender"),

          RadioListTile<String>(
            title: Text("Male"),
            value: "Male",
            groupValue: gender,
            onChanged: (v) => setState(() => gender = v!),
          ),

          RadioListTile<String>(
            title: Text("Female"),
            value: "Female",
            groupValue: gender,
            onChanged: (v) => setState(() => gender = v!),
          ),

          DropdownButton<String>(
            value: course,
            items: ["BCA", "BBA", "MCA"]
                .map((x) => DropdownMenuItem<String>(
                      value: x,
                      child: Text(x),
                    ))
                .toList(),
            onChanged: (v) => setState(() => course = v!),
          ),

          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(c).showSnackBar(
                SnackBar(content: Text("Registration Successful")),
              );
            },
            child: Text("Register"),
          ),
        ],
      ),
    ),
  );
}