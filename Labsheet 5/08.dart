//  Create a Flutter application to display a grid of colored boxes using GridView.builder. 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("Colored Grid"),
      ),

      body: GridView.builder(
        itemCount: 9,

        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),

        itemBuilder: (c, i) => Container(
          margin: EdgeInsets.all(5),
          color: Colors.blue,
        ),
      ),
    ),
  ),
);