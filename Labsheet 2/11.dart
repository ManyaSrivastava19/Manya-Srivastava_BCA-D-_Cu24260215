//  Create a Flutter application to design a simple student profile card using Container, Text, Image, and Icon widgets. 
import 'package:flutter/material.dart'; 
void main() { 
  runApp(MaterialApp( 
    home: Scaffold( 
      body: Center( 
        child: Container( 
          padding: EdgeInsets.all(20), 
          child: Column( 
            mainAxisSize: MainAxisSize.min, 
            children: [ 
              Image.network("https://picsum.photos/100"), 
              Text("Mohit Phulara", style: TextStyle(fontSize: 22)), 
              Text("BCA (AI & ML)"), 
              Icon(Icons.school, size: 40), 
            ], 
          ), 
        ), 
      ), 
    ), 
  )); 
} 