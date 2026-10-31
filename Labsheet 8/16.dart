// Create a Flutter Shopping Cart application that stores cart items in an SQLite database and displays the total price.
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ShoppingCart(),
  ));
}

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  Database? db;
  List<Map<String, dynamic>> items = [];
  double total = 0;

  final name = TextEditingController();
  final price = TextEditingController();
  final quantity = TextEditingController();

  @override
  void initState() {
    super.initState();
    initDB();
  }

  Future<void> initDB() async {
    String path = join(await getDatabasesPath(), 'cart.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Cart(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            price REAL,
            quantity INTEGER
          )
        ''');
      },
    );

    loadCart();
  }

  Future<void> loadCart() async {
    items = await db!.query('Cart');

    var result = await db!.rawQuery(
      'SELECT SUM(price * quantity) AS total FROM Cart',
    );

    total = (result.first['total'] as num?)?.toDouble() ?? 0;

    setState(() {});
  }

  Future<void> addItem() async {
    if (name.text.isEmpty ||
        price.text.isEmpty ||
        quantity.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final p = double.tryParse(price.text);
    final q = int.tryParse(quantity.text);

    if (p == null || q == null || p < 0 || q <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter valid price and quantity')),
      );
      return;
    }

    await db!.insert('Cart', {
      'name': name.text,
      'price': p,
      'quantity': q,
    });

    name.clear();
    price.clear();
    quantity.clear();

    loadCart();
  }

  Future<void> deleteItem(int id) async {
    await db!.delete(
      'Cart',
      where: 'id = ?',
      whereArgs: [id],
    );

    loadCart();
  }

  @override
  void dispose() {
    name.dispose();
    price.dispose();
    quantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        backgroundColor: Colors.blue,
      ),
      body: db == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TextField(
                        controller: name,
                        decoration: const InputDecoration(
                          labelText: 'Product Name',
                        ),
                      ),
                      TextField(
                        controller: price,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Price',
                        ),
                      ),
                      TextField(
                        controller: quantity,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: addItem,
                        child: const Text('Add to Cart'),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const Text(
                  'Cart Items',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: items.isEmpty
                      ? const Center(child: Text('Cart is Empty'))
                      : ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];

                            return ListTile(
                              title: Text(item['name']),
                              subtitle: Text(
                                'Price: ₹${item['price']} '
                                'x Quantity: ${item['quantity']}',
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => deleteItem(item['id']),
                              ),
                            );
                          },
                        ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  color: Colors.blue.shade100,
                  child: Text(
                    'Total Price: ₹${total.toStringAsFixed(2)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}