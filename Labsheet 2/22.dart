// Create a Flutter application to design a simple weather information screen containing location, temperature, weather icon, and other information. 
import 'package:flutter/material.dart'; 
void main() => runApp(MaterialApp( 
  home: Scaffold( 
    body: Column( 
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [ 
        Text("Meerut", style: TextStyle(fontSize: 25)), 
        Icon(Icons.wb_sunny, size: 60), 
        Text("30°C", style: TextStyle(fontSize: 35)), 
        Text("Sunny"), 
      ], 
    ), 
  ), 
));