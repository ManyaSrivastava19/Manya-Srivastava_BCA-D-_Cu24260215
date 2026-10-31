//  Create a Flutter application to write text into a file in the application’s documents directory using the path_provider package. 
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MaterialApp(home: App()));

class App extends StatelessWidget {

  // Save text into a file
  void save() async {
    var d = await getApplicationDocumentsDirectory();

    File("${d.path}/data.txt")
        .writeAsString("Hello Flutter");
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text("File Storage")),
      body: Center(
        child: ElevatedButton(
          onPressed: save,
          child: Text("Save"),
        ),
      ),
    );
  }
}