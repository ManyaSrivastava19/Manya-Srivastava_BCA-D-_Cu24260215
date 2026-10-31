//  Create a Flutter application with a Home Screen and a Detail Screen and implement forward and backward navigation. 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: Home()),
);

class Home extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Home Screen")),
    body: Center(
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          c,
          MaterialPageRoute(builder: (_) => Detail()),
        ),
        child: Text("Details"),
      ),
    ),
  );
}

class Detail extends StatelessWidget {
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Detail Screen")),
    body: Center(
      child: ElevatedButton(
        onPressed: () => Navigator.pop(c),
        child: Text("Back"),
      ),
    ),
  );
}