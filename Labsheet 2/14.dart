//  Create a Flutter application to design a simple registration screen containing name, email, password, and a registration button. 
import 'package:flutter/material.dart'; 
void main() => runApp(MaterialApp( 
  home: Scaffold( 
    body: Column( 
      children: [ 
        TextField(decoration: InputDecoration(labelText: "Name")), 
        TextField(decoration: InputDecoration(labelText: "Email")), 
        TextField(decoration: InputDecoration(labelText: "Password")), 
        ElevatedButton(onPressed: () {}, child: Text("Register")), 
      ], 
    ), 
  ), 
));