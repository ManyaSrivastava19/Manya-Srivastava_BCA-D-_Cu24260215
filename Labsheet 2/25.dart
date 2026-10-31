Create a Flutter application to design a personal profile/home screen by combining Text, Image, Icon, Container, Row, Column, Card, and Button widgets 
import 'package:flutter/material.dart'; 
void main() => runApp(MaterialApp( 
  home: Scaffold( 
    body: Container( 
      padding: EdgeInsets.all(20), 
      child: Column( 
        children: [ 
          Image.network("https://picsum.photos/100"), 
          Text("Mohit Phulara", style: TextStyle(fontSize: 24)), 
          Text("BCA Student"), 
          Icon(Icons.person, size: 40), 
          Card(child: Text("My Profile")), 
          Row( 
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [ 
              ElevatedButton(onPressed: () {}, child: Text("Home")), 
              ElevatedButton(onPressed: () {}, child: Text("Contact")), 
            ], 
          ), 
        ], 
      ), 
    ), 
  ), 
)); 
 
