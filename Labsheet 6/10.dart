// Create a Flutter application to remove stored SharedPreferences data using a Clear button.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(home: App()));

class App extends StatelessWidget {

  // Clear all saved data
  void clear() async {
    var p = await SharedPreferences.getInstance();

    await p.clear();
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text("Clear Preferences")),
      body: Center(
        child: ElevatedButton(
          onPressed: clear,
          child: Text("Clear"),
        ),
      ),
    );
  }
}