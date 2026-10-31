//  Create a Flutter application to delete an item from a list when the user taps the delete icon. 
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
      title: Text("Fruit List"),
    ),

    body: ListView.builder(
      itemCount: items.length,

      itemBuilder: (c, i) => ListTile(
        title: Text(items[i]),

        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),

          onPressed: () {
            setState(() {
              items.removeAt(i);
            });
          },
        ),
      ),
    ),
  );
}