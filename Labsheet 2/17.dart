// Create a Flutter application using the Card widget to display student information such as name, roll number, course, and semester. 
import 'package:flutter/material.dart'; 
void main() => runApp(MaterialApp( 
  home: Scaffold( 
    body: Card( 
      child: Column( 
        children: [ 
          Text("Name: Mohit"), 
          Text("Roll No: 101"), 
          Text("Course: BCA"), 
          Text("Semester: 4th"), 
        ], 
      ), 
    ), 
  ), 
));