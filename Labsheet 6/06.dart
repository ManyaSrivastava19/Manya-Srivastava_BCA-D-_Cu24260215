//  Create a Flutter application to save a Dark Mode ON/OFF setting using a Switch and SharedPreferences. 
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(home: App()));

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  bool dark = false;

  // Load saved theme setting
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((p) {
      setState(() {
        dark = p.getBool("dark") ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text("Dark Mode App")),
      backgroundColor: dark ? Colors.black : Colors.white,
      body: Center(
        child: Switch(
          value: dark,
          onChanged: (v) async {
            var p = await SharedPreferences.getInstance();

            await p.setBool("dark", v);

            setState(() {
              dark = v;
            });
          },
        ),
      ),
    );
  }
}