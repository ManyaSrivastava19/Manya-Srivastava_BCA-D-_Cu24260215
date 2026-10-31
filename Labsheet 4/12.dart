// Create a Flutter application to open different screens using options provided in a Navigation Drawer. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Home")),

    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              "Navigation Menu",
              style: TextStyle(fontSize: 22),
            ),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () => Navigator.pop(c),
          ),

          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () => Navigator.push(
              c,
              MaterialPageRoute(builder: (_) => Profile()),
            ),
          ),

          ListTile(
            leading: Icon(Icons.info),
            title: Text("About"),
            onTap: () => Navigator.push(
              c,
              MaterialPageRoute(builder: (_) => About()),
            ),
          ),
        ],
      ),
    ),

    body: Center(child: Text("Home Screen")),
  );
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Profile")),
    body: Center(child: Text("Profile Screen")),
  );
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("About")),
    body: Center(child: Text("About Screen")),
  );
}