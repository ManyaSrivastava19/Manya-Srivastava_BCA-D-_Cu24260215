// Create a Flutter application to design a simple login screen using Text, TextField, Button, and Image widgets. 
import 'package:flutter/material.dart'; 
void main() { 
  runApp(MaterialApp( 
    home: Scaffold( 
      body: Padding( 
        padding: EdgeInsets.all(20), 
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [ 
            Image.network("https://picsum.photos/100"), 
            Text("Login", style: TextStyle(fontSize: 25)), 
            TextField(decoration: InputDecoration(labelText: "Username")), 
            TextField(decoration: InputDecoration(labelText: "Password")), 
            ElevatedButton( 
              onPressed: () {}, 
              child: Text("Login"), 
            ), 
          ], 
        ), 
      ), 
    ), 
  )); 
}