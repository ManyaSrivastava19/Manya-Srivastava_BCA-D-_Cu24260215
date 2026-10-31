//  Create a Flutter application to display a list of items with a leading icon, title, and  subtitle using ListTile.    
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("Student List"),
      ),

      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Mohit"),
            subtitle: Text("BCA Student"),
          ),

          ListTile(
            leading: Icon(Icons.person),
            title: Text("Rahul"),
            subtitle: Text("BCA Student"),
          ),
        ],
      ),
    ),
  ),
);