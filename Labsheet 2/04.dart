// Create a Flutter application to display an image using the Image widget. 
import 'package:flutter/material.dart'; 
void main() { 
  runApp(MaterialApp( 
    home: Scaffold( 
      appBar: AppBar(title: Text("Image Example")), 
      body: Center( 
        child: Image.network( 
          "https://picsum.photos/200", 
        ), 
      ), 
    ), 
  )); 
} 
