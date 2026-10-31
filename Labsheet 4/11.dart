// Create a Flutter application with a simple home screen and a drawer containing Home, Profile, About, and Settings options. 
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
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white, fontSize: 24),
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
            onTap: () => Navigator.pop(c),
          ),

          ListTile(
            leading: Icon(Icons.info),
            title: Text("About"),
            onTap: () => Navigator.pop(c),
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () => Navigator.pop(c),
          ),
        ],
      ),
    ),

    body: Center(child: Text("Home Screen")),
  );
}