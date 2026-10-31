// Develop a Flutter Product Store Application that fetches a list of products (title, price, and image) from a public REST API, displays them in a GridView, and shows product details on a separate screen with a loading indicator and error handling.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProductScreen(),
  ));
}

// Product Model
class Product {
  final int id;
  final String title;
  final double price;
  final String image;
  final String description;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      description: json['description'],
      category: json['category'],
    );
  }
}

// Fetch Products from API
Future<List<Product>> fetchProducts() async {
  final response = await http.get(
    Uri.parse('https://fakestoreapi.com/products'),
  ).timeout(Duration(seconds: 15));

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);

    return data
        .map((item) => Product.fromJson(item))
        .toList();
  } else {
    throw Exception('Failed to load products');
  }
}

// Product List Screen
class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  void retry() {
    setState(() {
      futureProducts = fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Store'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {

          // Loading Indicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error Handling
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 50),
                  SizedBox(height: 10),
                  Text('Unable to load products'),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: retry,
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final products = snapshot.data!;

          // Display Products in GridView
          return GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: products.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              final product = products[index];

              return Card(
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Center(
                            child: Image.network(
                              product.image,
                              fit: BoxFit.contain,
                              errorBuilder:
                                  (context, error, stackTrace) {
                                return Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'View Details',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Product Detail Screen
class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image,
                height: 220,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image_not_supported, size: 70);
                },
              ),
            ),
            SizedBox(height: 20),

            Text(
              product.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 22,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 15),

            Text(
              'Category: ${product.category}',
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 15),

            Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 15),

            Text('Product ID: ${product.id}'),
          ],
        ),
      ),
    );
  }
}