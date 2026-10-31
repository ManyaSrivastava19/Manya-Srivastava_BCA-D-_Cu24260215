// Create a Flutter application to show a welcome screen only on the first launch of the application using SharedPreferences. 
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(home: App()));

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  bool first = true;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    checkFirstLaunch();
  }

  // Check whether app is opened for the first time
  void checkFirstLaunch() async {
    var p = await SharedPreferences.getInstance();

    bool seen = p.getBool("seen") ?? false;

    setState(() {
      first = !seen;
      loading = false;
    });

    if (!seen) {
      await p.setBool("seen", true);
    }
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text("My App")),
      body: Center(
        child: loading
            ? CircularProgressIndicator()
            : Text(
                first ? "Welcome!" : "Home Screen",
                style: TextStyle(fontSize: 25),
              ),
      ),
    );
  }
}