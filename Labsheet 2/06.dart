//  Create a Flutter application containing Text, Image, and Icon widgets on the same screen. 
import 'package:flutter/material.dart'; 
void main() { 
  runApp(MaterialApp( 
    home: Scaffold( 
      body: Center( 
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [ 
            Text("Hello Flutter", style: TextStyle(fontSize: 25)), 
            Image.network("https://picsum.photos/150"), 
            Icon(Icons.favorite, size: 50), 
          ], 
        ), 
      ), 
    ), 
  )); 
}