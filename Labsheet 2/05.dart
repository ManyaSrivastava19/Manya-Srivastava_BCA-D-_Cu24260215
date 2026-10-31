// Create a Flutter application to display different icons using the Icon widget. 
import 'package:flutter/material.dart'; 
void main() { 
  runApp(MaterialApp( 
    home: Scaffold( 
      appBar: AppBar(title: Text("Icons Example")), 
      body: Row( 
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [ 
          Icon(Icons.home, size: 50), 
          Icon(Icons.favorite, size: 50), 
          Icon(Icons.star, size: 50), 
        ], 
      ), 
    ), 
  )); 
}