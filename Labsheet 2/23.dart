//  Create a Flutter application to design a simple shopping product screen using Image, Text, Icon, Card, and Button widgets. 
import 'package:flutter/material.dart'; 
void main() => runApp(MaterialApp( 
  home: Scaffold( 
    body: Card( 
      child: Column( 
        children: [ 
          Image.network("https://picsum.photos/150"), 
          Text("Smart Watch"), 
          Text("₹1999"), 
          Icon(Icons.favorite), 
          ElevatedButton( 
            onPressed: () {}, 
            child: Text("Buy Now"), 
          ), 
        ], 
      ), 
    ), 
  ), 
));