// Create a Flutter application to add a new item to a list using a TextField and a button. 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: App()),
);

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  final t = TextEditingController();

  List<String> items = [];

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(
      title: Text("Add Items"),
    ),

    body: Padding(
      padding: EdgeInsets.all(15),

      child: Column(
        children: [
          TextField(
            controller: t,
            decoration: InputDecoration(
              labelText: "Enter Item",
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 10),

          ElevatedButton(
            onPressed: () {
              if (t.text.trim().isNotEmpty) {
                setState(() {
                  items.add(t.text.trim());
                  t.clear();
                });
              }
            },
            child: Text("Add"),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: items.length,

              itemBuilder: (c, i) => ListTile(
                title: Text(items[i]),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}