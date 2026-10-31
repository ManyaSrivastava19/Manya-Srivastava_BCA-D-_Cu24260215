//  Create a Flutter application to implement a “Remember Me” checkbox on a login screen using SharedPreferences. 
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(home: App()));

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  bool r = false;

  // Load saved Remember Me setting
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((p) {
      setState(() {
        r = p.getBool("remember") ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Screen")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            CheckboxListTile(
              title: Text("Remember Me"),
              value: r,
              onChanged: (v) async {
                var p = await SharedPreferences.getInstance();

                await p.setBool("remember", v!);

                setState(() {
                  r = v;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}