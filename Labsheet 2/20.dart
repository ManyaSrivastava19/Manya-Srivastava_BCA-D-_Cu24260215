// Create a Flutter application to design a simple food menu screen using images, text, icons, and buttons. 
import 'package:flutter/material.dart'; 
void main() => runApp(MaterialApp( 
  home: Scaffold( 
    body: Column( 
      children: [ 
        Image.network("https://picsum.photos/100"), 
        Text("Pizza - ₹200"), 
        Icon(Icons.restaurant), 
        ElevatedButton(onPressed: () {}, child: Text("Order")), 
      ], 
    ), 
  ), 
));