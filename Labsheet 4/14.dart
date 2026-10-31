//  Create a Flutter application with Home, Courses, and Contact screens and navigate between them using a BottomNavigationBar. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: App()));

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  int i = 0;

  final pages = [
    Text("Home"),
    Text("Courses"),
    Text("Contact"),
  ];

  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("My App")),

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
          icon: Icon(Icons.book),
          label: "Courses",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.call),
          label: "Contact",
        ),
      ],
    ),
  );
}