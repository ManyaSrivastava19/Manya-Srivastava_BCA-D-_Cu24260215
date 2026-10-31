//  Create a Flutter application to demonstrate the difference between StatelessWidget and StatefulWidget. 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: App()),
);

// StatelessWidget
class App extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(
      title: Text("Widget Example"),
    ),

    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "StatelessWidget",
          style: TextStyle(fontSize: 22),
        ),

        SizedBox(height: 20),

        Counter(),
      ],
    ),
  );
}

// StatefulWidget
class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _S();
}

class _S extends State<Counter> {
  int n = 0;

  @override
  Widget build(BuildContext c) => Column(
    children: [
      Text(
        "Count: $n",
        style: TextStyle(fontSize: 22),
      ),

      ElevatedButton(
        onPressed: () => setState(() => n++),
        child: Text("Click"),
      ),
    ],
  );
}