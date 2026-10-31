// Create a Flutter application with a Home Screen containing a button that opens a separate Profile Screen. 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: Home()),
);

class Home extends StatelessWidget {
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
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Profile")),
    body: Center(
      child: Text("Profile Screen"),
    ),
  );
}