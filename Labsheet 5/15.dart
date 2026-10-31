//  Create a Flutter application to remove list items by swiping them using the Dismissible widget. 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: App()),
);

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  List<String> items = ["Apple", "Banana", "Mango"];

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(
      title: Text("Dismissible List"),
    ),

    body: ListView.builder(
      itemCount: items.length,

      itemBuilder: (c, i) => Dismissible(
        key: Key(items[i]),

        background: Container(
          color: Colors.red,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(15),
          child: Icon(Icons.delete, color: Colors.white),
        ),

        onDismissed: (_) {
          setState(() {
            items.removeAt(i);
          });
        },

        child: ListTile(
          title: Text(items[i]),
        ),
      ),
    ),
  );
}