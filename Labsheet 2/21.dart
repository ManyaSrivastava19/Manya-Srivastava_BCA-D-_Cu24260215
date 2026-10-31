// Create a Flutter application to design a simple calculator interface using buttons and basic layout widgets. 
import 'package:flutter/material.dart'; 
void main() => runApp(MaterialApp( 
  home: Scaffold( 
    body: Column( 
      children: [ 
        Text("0", style: TextStyle(fontSize: 30)), 
        Row( 
          children: [ 
            ElevatedButton(onPressed: () {}, child: Text("1")), 
            ElevatedButton(onPressed: () {}, child: Text("2")), 
            ElevatedButton(onPressed: () {}, child: Text("+")), 
          ], 
        ), 
        Row( 
          children: [ 
            ElevatedButton(onPressed: () {}, child: Text("3")), 
            ElevatedButton(onPressed: () {}, child: Text("4")), 
            ElevatedButton(onPressed: () {}, child: Text("=")), 
          ], 
        ), 
      ], 
    ), 
  ), 
));