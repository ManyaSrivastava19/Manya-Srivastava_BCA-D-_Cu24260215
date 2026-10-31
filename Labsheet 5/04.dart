// Create a Flutter application to display a list of names stored in a Dart List using ListView.builder. 
import 'package:flutter/material.dart';

List<String> names = ["Manya", "Riya", "Priya", "Neha"];

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("Name List"),
      ),

      body: ListView.builder(
        itemCount: names.length,

        itemBuilder: (c, i) => ListTile(
          title: Text(names[i]),
        ),
      ),
    ),
  ),
);