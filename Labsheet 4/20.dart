//  Create a Flutter application with a Home Screen and Product Detail Screen. Pass the product name and price to the Product Detail Screen. 
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Home Screen")),

    body: Center(
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          c,
          MaterialPageRoute(
            builder: (_) => Detail("Laptop", 50000),
          ),
        ),
        child: Text("Product Details"),
      ),
    ),
  );
}

class Detail extends StatelessWidget {
  String n;
  int p;

  Detail(this.n, this.p);

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: Text("Product Details")),

    body: Center(
      child: Text(
        "$n\nPrice: ₹$p",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25),
      ),
    ),
  );
}