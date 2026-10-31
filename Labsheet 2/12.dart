//  Create a Flutter application to design a simple business card containing name, phone number, email, and profile image. 
import 'package:flutter/material.dart'; 
void main() { 
  runApp(MaterialApp( 
    home: Scaffold( 
      body: Center( 
        child: Container( 
          padding: EdgeInsets.all(20), 
          child: Column( 
            mainAxisSize: MainAxisSize.min, 
            children: [ 
              Image.network("https://picsum.photos/100"), 
              Text("Mohit Phulara", style: TextStyle(fontSize: 22)), 
              Text("Phone: 9876543210"), 
              Text("Email: mohit@gmail.com"), 
            ], 
          ), 
        ), 
      ), 
    ), 
  )); 
}