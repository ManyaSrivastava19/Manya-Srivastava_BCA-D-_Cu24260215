// Create a Flutter application containing three buttons: Submit, Reset, and Cancel. 
import 'package:flutter/material.dart'; 
void main() { 
  runApp(MaterialApp( 
    home: Scaffold( 
      body: Center( 
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [ 
            ElevatedButton(onPressed: () {}, child: Text("Submit")), 
            ElevatedButton(onPressed: () {}, child: Text("Reset")), 
            ElevatedButton(onPressed: () {}, child: Text("Cancel")), 
          ], 
        ), 
      ), 
    ), 
  )); 
} 
 