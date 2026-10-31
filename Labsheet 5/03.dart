//  Create a Flutter application to display the numbers from 1 to 100 using  ListView.builder.    
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("Numbers 1 to 100"),
      ),

      body: ListView.builder(
        itemCount: 100,

        itemBuilder: (c, i) => ListTile(
          title: Text("${i + 1}"),
        ),
      ),
    ),
  ),
);