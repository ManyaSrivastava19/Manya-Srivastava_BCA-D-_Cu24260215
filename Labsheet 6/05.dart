// Create a Flutter application to store and retrieve an integer counter value using SharedPreferences. 
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(home: App()));

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  int n = 0;

  // Increment and save counter
  void add() async {
    var p = await SharedPreferences.getInstance();

    setState(() {
      n++;
    });

    await p.setInt("count", n);
  }

  // Retrieve saved counter when app starts
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((p) {
      setState(() {
        n = p.getInt("count") ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$n",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: add,
              child: Text("Increment"),
            ),
          ],
        ),
      ),
    );
  }
}