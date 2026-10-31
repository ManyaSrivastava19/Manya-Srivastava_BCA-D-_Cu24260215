//  Create a Flutter application with a counter that increases when a button is pressed using setState(). 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: App()),
);

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  int n = 0;

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(
      title: Text("Counter App"),
    ),

    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Count: $n",
            style: TextStyle(fontSize: 25),
          ),

          ElevatedButton(
            onPressed: () => setState(() => n++),
            child: Text("Increase"),
          ),
        ],
      ),
    ),
  );
}