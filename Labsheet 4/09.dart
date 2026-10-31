//  Create a Flutter application containing a BottomNavigationBar with Home, Profile, and Settings screens. 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: MyApp()),
);

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _S();
}

class _S extends State<MyApp> {
  int i = 0;

  final pages = [
    Text("Home"),
    Text("Profile"),
    Text("Settings"),
  ];

  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Bottom Navigation")),

    body: Center(
      child: pages[i],
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