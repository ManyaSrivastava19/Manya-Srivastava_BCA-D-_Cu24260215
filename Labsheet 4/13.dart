// Create a Flutter application with an AppBar and navigation drawer containing icons and text for different menu items. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(
      title: Text("Home"),
    ),

    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              "Menu",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
          ),

          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
          ),

          ListTile(
            leading: Icon(Icons.info),
            title: Text("About"),
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
        ],
      ),
    ),

    body: Center(
      child: Text("Home Screen"),
    ),
  );
}