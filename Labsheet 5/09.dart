// Create a Flutter application to display a list of products (name and price) using a Dart model class and ListView.builder. 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: Home()),
);

// Product Model Class
class Product {
  String name;
  double price;

  Product(this.name, this.price);
}

// Home Screen
class Home extends StatelessWidget {
  final p = [
    Product("Laptop", 50000),
    Product("Mobile", 20000),
    Product("Watch", 3000),
  ];

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(
      title: Text("Product List"),
    ),

    body: ListView.builder(
      itemCount: p.length,

      itemBuilder: (c, i) => ListTile(
        leading: Icon(Icons.shopping_bag),
        title: Text(p[i].name),
        subtitle: Text("₹${p[i].price}"),
      ),
    ),
  );
}