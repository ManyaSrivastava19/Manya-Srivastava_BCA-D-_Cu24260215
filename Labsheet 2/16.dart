// Create a Flutter application to display multiple products using Container and Card widgets. 
import 'package:flutter/material.dart'; 
void main() => runApp(MaterialApp( 
  home: Scaffold( 
    body: Column( 
      children: [ 
        Card(child: Text("Mobile - ₹15000")), 
        Card(child: Text("Laptop - ₹50000")), 
        Card(child: Text("Headphones - ₹2000")), 
      ], 
    ), 
  ), 
));