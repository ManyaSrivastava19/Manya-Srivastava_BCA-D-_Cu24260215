//  Create a Flutter application with Home Screen and About Screen and navigate between them using a button. 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: Home()),
);

class Home extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(
      title: Text("Home"),
    ),
    body: Center(
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          c,
          MaterialPageRoute(builder: (_) => About()),
        ),
        child: Text("Go to About"),
      ),
    ),
  );
}

class About extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(
      title: Text("About"),
    ),
    body: Center(
      child: Text("About Screen"),
    ),
  );
}