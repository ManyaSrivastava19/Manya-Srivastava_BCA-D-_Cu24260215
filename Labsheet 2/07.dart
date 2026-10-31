// Create a Flutter application using the Container widget and customize its height, width, padding, margin, and decoration. 
import 'package:flutter/material.dart'; 
void main() { 
  runApp(MaterialApp( 
    home: Scaffold( 
      body: Center( 
        child: Container( 
          height: 150, 
          width: 250, 
          padding: EdgeInsets.all(20), 
          margin: EdgeInsets.all(10), 
          decoration: BoxDecoration( 
            color: Colors.blue, 
            borderRadius: BorderRadius.circular(15), 
          ), 
          child: Text("Hello Flutter"), 
        ), 
      ), 
    ), 
  )); 
}