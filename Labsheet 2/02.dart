//  Create a Flutter application to display your name, course, semester, and college name using Text widgets 
import 'package:flutter/material.dart'; 
 
void main() { 
  runApp(MaterialApp( 
    home: Scaffold( 
      body: Center( 
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [ 
            Text("Name: Manya Srivastava"), 
            Text("Course: BCA "), 
            Text("Semester: 5th"), 
            Text("College: COER University "), 
          ], 
        ), 
      ), 
    ), 
  )); 
}