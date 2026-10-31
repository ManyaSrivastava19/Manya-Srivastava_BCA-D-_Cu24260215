// Create a Flutter application to demonstrate different text styles such as bold, italic, different font sizes, and text alignment. 
import 'package:flutter/material.dart'; 
void main() { 
  runApp(MaterialApp( 
    home: Scaffold( 
      appBar: AppBar(title: Text("Text Styles")), 
      body: Column( 
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [ 
          Text("Bold Text", 
              style: TextStyle(fontWeight: FontWeight.bold)), 
          Text("Italic Text", 
              style: TextStyle(fontStyle: FontStyle.italic)), 
          Text("Large Text", 
              style: TextStyle(fontSize: 30)), 
          Text("Small Text", 
              style: TextStyle(fontSize: 15)), 
          Text("Center Aligned Text", 
              textAlign: TextAlign.center), 
        ], 
      ), 
    ), 
  )); 
} 