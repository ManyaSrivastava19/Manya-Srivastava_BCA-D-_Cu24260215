// Create a Flutter application using BottomNavigationBar to switch between three different screens. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: App()));

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  int i = 0;

  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Bottom Navigation")),

    body: Center(
      child: Text(
        ["Home", "Profile", "Settings"][i],
        style: TextStyle(fontSize: 25),
      ),
    ),

    bottomNavigationBar: BottomNavigationBar(
      currentIndex: i,
      onTap: (x) => setState(() => i = x),

      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
        ),
      ],
    ),
  );
}