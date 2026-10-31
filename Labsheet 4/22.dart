//  Create a Flutter application with a Login Screen, Home Screen, and Profile Screen and implement navigation between them. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Login()));

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Login Screen")),

    body: Center(
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          c,
          MaterialPageRoute(builder: (_) => Home()),
        ),
        child: Text("Login"),
      ),
    ),
  );
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Home Screen")),

    body: Center(
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          c,
          MaterialPageRoute(builder: (_) => Profile()),
        ),
        child: Text("Profile"),
      ),
    ),
  );
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Profile Screen")),

    body: Center(
      child: Text(
        "Profile Screen",
        style: TextStyle(fontSize: 25),
      ),
    ),
  );
}