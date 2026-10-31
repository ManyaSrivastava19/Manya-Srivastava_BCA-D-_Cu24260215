//  Create a Flutter application to design a simple student dashboard containing profile information 
and different menu cards. 
import 'package:flutter/material.dart'; 
void main() => runApp(MaterialApp( 
  home: Scaffold( 
    body: Column( 
      children: [ 
        Text("Student Dashboard", 
            style: TextStyle(fontSize: 25)), 
        Text("Name: Manya Srivastava"), 
        Text("Course: BCA"), 
        Card(child: Text("Profile")), 
        Card(child: Text("Attendance")), 
        Card(child: Text("Results")), 
      ], 
    ), 
  ), 
));