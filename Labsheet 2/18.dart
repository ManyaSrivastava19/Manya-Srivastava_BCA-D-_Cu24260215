 // Create a Flutter application to demonstrate the use of Padding and Margin for arranging UI elements properly. 
import 'package:flutter/material.dart'; 
void main() => runApp(MaterialApp( 
  home: Scaffold( 
    body: Container( 
      margin: EdgeInsets.all(20), 
      padding: EdgeInsets.all(20), 
      child: Text("Hello Flutter"), 
    ), 
  ), 
));