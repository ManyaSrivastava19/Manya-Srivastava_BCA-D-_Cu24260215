//  Create a Flutter application to read text from a stored file and display it on the screen. 
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MaterialApp(home: App()));

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  String text = "";

  // Read text from file
  void read() async {
    var d = await getApplicationDocumentsDirectory();

    File file = File("${d.path}/data.txt");

    if (await file.exists()) {
      text = await file.readAsString();
    } else {
      text = "File not found!";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text("Read File")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: read,
              child: Text("Read"),
            ),
            SizedBox(height: 20),
            Text(
              text,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}