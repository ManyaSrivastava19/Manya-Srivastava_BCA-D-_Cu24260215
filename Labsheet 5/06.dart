// Create a Flutter application to display a horizontally scrolling list using the scrollDirection property. 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("Horizontal List"),
      ),

      body: ListView(
        scrollDirection: Axis.horizontal,

        children: [
          Text("Item 1"),
          Text("Item 2"),
          Text("Item 3"),
          Text("Item 4"),
          Text("Item 5"),
        ],
      ),
    ),
  ),
);