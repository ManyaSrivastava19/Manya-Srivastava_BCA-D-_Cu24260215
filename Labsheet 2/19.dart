// Create a Flutter application to demonstrate different alignment options using Center and Align widgets. 
import 'package:flutter/material.dart'; 
void main() => runApp(MaterialApp( 
  home: Scaffold( 
    body: Column( 
      children: [ 
        Center(child: Text("Center")), 
        Align( 
          alignment: Alignment.topRight, 
          child: Text("Right"), 
        ), 
      ], 
    ), 
  ), 
));