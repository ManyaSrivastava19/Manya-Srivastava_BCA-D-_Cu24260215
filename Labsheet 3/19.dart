//  Create a Flutter application using a Switch to turn a setting ON and OFF. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _S();
}

class _S extends State<MyApp> {
  bool on = false;

  Widget build(BuildContext c) => Scaffold(
    body: Center(
      child: Switch(
        value: on,
        onChanged: (v) => setState(() => on = v),
      ),
    ),
  );
}