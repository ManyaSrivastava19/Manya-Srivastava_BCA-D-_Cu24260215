// Create a Flutter application to filter a list of names using a search TextField. 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: App()),
);

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  List<String> names = [
    "Mohit",
    "Rahul",
    "Aman",
    "Priya",
    "Neha"
  ];

  String s = "";

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(
      title: Text("Search Names"),
    ),

    body: Column(
      children: [
        TextField(
          onChanged: (v) => setState(() => s = v),
          decoration: InputDecoration(
            labelText: "Search",
            prefixIcon: Icon(Icons.search),
          ),
        ),

        Expanded(
          child: ListView(
            children: names
                .where((x) => x.toLowerCase()
                    .contains(s.toLowerCase()))
                .map((x) => ListTile(
                      title: Text(x),
                    ))
                .toList(),
          ),
        ),
      ],
    ),
  );
}