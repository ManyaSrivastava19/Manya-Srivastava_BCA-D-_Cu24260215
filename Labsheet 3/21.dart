// Create a Flutter Login Form UI with username, password, Login button, and Reset button. 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: MyApp(),
  ),
);

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _S();
}

class _S extends State<MyApp> {
  final username = TextEditingController();
  final password = TextEditingController();

  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Login Form")),
    body: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: username,
            decoration: InputDecoration(
              labelText: "Username",
            ),
          ),

          TextField(
            controller: password,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
            ),
          ),

          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(c).showSnackBar(
                    SnackBar(content: Text("Login Successful")),
                  );
                },
                child: Text("Login"),
              ),

              SizedBox(width: 10),

              ElevatedButton(
                onPressed: () {
                  username.clear();
                  password.clear();
                },
                child: Text("Reset"),
              ),
            ],
          ),
        ],
      ),
    ),
  );
} 