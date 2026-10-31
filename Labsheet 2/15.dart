 // Create a Flutter application to design a simple college home screen containing college name, logo, and menu options. 
import 'package:flutter/material.dart'; 
void main() => runApp(MaterialApp( 
  home: Scaffold( 
    body: Column( 
      children: [ 
        Image.network("https://picsum.photos/80"), 
        Text("Haridwar University", 
            style: TextStyle(fontSize: 22)), 
        Text("Home | Courses | About | Contact"), 
      ], 
    ), 
  ), 
))