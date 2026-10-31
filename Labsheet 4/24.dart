//  Create a Flutter application for a simple shopping app containing Home, Products, Cart, and Profile screens using BottomNavigationBar or Navigation Drawer. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: App()));

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  int i = 0;

  final pages = [
    "Home",
    "Products",
    "Cart",
    "Profile",
  ];

  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Shopping App")),

    body: Center(
      child: Text(
        pages[i],
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
          icon: Icon(Icons.shopping_bag),
          label: "Products",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: "Cart",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    ),
  );
}