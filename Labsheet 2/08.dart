// Create a Flutter application to display multiple Text widgets horizontally using the Row widget. 
import 'package:flutter/material.dart'; 
void main() { 
  runApp(MaterialApp( 
    home: Scaffold( 
      body: Row( 
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [ 
          Text("Hello"), 
          Text("Flutter"), 
          Text("World"), 
        ], 
      ), 
    ), 
  )); 
}