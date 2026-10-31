// Create a Flutter application to navigate from a Login Screen to a Home Screen when the Login button is pressed. 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: Login()),
);

class Login extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Login")),
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
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Home")),
    body: Center(
      child: Text("Home Screen"),
    ),
  );
}