//  Create a Flutter application to display multiple Text widgets vertically using the Column widget. 
import 'package:flutter/material.dart'; 
void main() { 
  runApp(MaterialApp( 
    home: Scaffold( 
      body: Column( 
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
 