// Create a Flutter Product Inventory application that stores products (name, quantity, and price) in an SQLite database and allows adding, updating, and deleting products.
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProductInventory(),
  ));
}

class ProductInventory extends StatefulWidget {
  const ProductInventory({super.key});

  @override
  State<ProductInventory> createState() => _ProductInventoryState();
}

class _ProductInventoryState extends State<ProductInventory> {
  Database? db;
  List<Map<String, dynamic>> products = [];

  final name = TextEditingController();
  final quantity = TextEditingController();
  final price = TextEditingController();

  int? editId;

  @override
  void initState() {
    super.initState();
    initDB();
  }

  Future<void> initDB() async {
    String path = join(await getDatabasesPath(), 'products.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            quantity INTEGER,
            price REAL
          )
        ''');
      },
    );

    loadProducts();
  }

  Future<void> loadProducts() async {
    if (db == null) return;

    products = await db!.query('Products', orderBy: 'id DESC');
    setState(() {});
  }

  Future<void> saveProduct() async {
    if (name.text.isEmpty ||
        quantity.text.isEmpty ||
        price.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (int.tryParse(quantity.text) == null ||
        double.tryParse(price.text) == null ||
        double.parse(price.text) < 0 ||
        int.parse(quantity.text) < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter valid quantity and price')),
      );
      return;
    }

    Map<String, dynamic> data = {
      'name': name.text,
      'quantity': int.parse(quantity.text),
      'price': double.parse(price.text),
    };

    if (editId == null) {
      await db!.insert('Products', data);
    } else {
      await db!.update(
        'Products',
        data,
        where: 'id = ?',
        whereArgs: [editId],
      );
    }

    clearFields();
    loadProducts();
  }

  void editProduct(Map<String, dynamic> product) {
    name.text = product['name'];
    quantity.text = product['quantity'].toString();
    price.text = product['price'].toString();
    editId = product['id'];
  }

  Future<void> deleteProduct(int id) async {
    await db!.delete(
      'Products',
      where: 'id = ?',
      whereArgs: [id],
    );
    loadProducts();
  }

  void clearFields() {
    name.clear();
    quantity.clear();
    price.clear();
    editId = null;
  }

  @override
  void dispose() {
    name.dispose();
    quantity.dispose();
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Inventory'),
        backgroundColor: Colors.blue,
      ),
      body: db == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      TextField(
                        controller: name,
                        decoration: const InputDecoration(
                          labelText: 'Product Name',
                        ),
                      ),
                      TextField(
                        controller: quantity,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                        ),
                      ),
                      TextField(
                        controller: price,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Price',
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: saveProduct,
                        child: Text(
                          editId == null ? 'Add Product' : 'Update Product',
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: products.isEmpty
                      ? const Center(child: Text('No Products Found'))
                      : ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];

                            return Card(
                              child: ListTile(
                                title: Text(product['name']),
                                subtitle: Text(
                                  'Quantity: ${product['quantity']}\n'
                                  'Price: ₹${product['price']}',
                                ),
                                isThreeLine: true,
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        setState(() {
                                          editProduct(product);
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        deleteProduct(product['id']);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}