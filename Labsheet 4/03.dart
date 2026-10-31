//  Create a Flutter application with three screens: Home, Profile, and Settings, and navigate between the screens. 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: Home()),
);

class Home extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Home")),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.push(
              c,
              MaterialPageRoute(builder: (_) => Profile()),
            ),
            child: Text("Profile"),
          ),

          ElevatedButton(
            onPressed: () => Navigator.push(
              c,
              MaterialPageRoute(builder: (_) => Settings()),
            ),
            child: Text("Settings"),
          ),
        ],
      ),
    ),
  );
}

class Profile extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Profile")),
    body: Center(child: Text("Profile Screen")),
  );
}

class Settings extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Settings")),
    body: Center(child: Text("Settings Screen")),
  );
}