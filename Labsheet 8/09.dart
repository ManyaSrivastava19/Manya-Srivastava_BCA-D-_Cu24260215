// Extend the Expense Tracker application to display the total expense using the SUM function.

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ExpenseApp(),
  ));
}

class ExpenseApp extends StatefulWidget {
  @override
  State<ExpenseApp> createState() => _ExpenseAppState();
}

class _ExpenseAppState extends State<ExpenseApp> {
  Database? db;
  List<Map<String, dynamic>> expenses = [];
  double total = 0;

  TextEditingController title = TextEditingController();
  TextEditingController amount = TextEditingController();

  Future<void> initDB() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'expenses.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Expenses(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, amount REAL)',
        );
      },
    );
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    expenses = await db!.query('Expenses', orderBy: 'id DESC');

    var result = await db!.rawQuery(
      'SELECT SUM(amount) AS total FROM Expenses',
    );

    total = (result.first['total'] as num?)?.toDouble() ?? 0.0;

    setState(() {});
  }

  Future<void> addExpense() async {
    if (title.text.isEmpty || amount.text.isEmpty) return;

    double? value = double.tryParse(amount.text);
    if (value == null || value <= 0) return;

    await db!.insert('Expenses', {
      'title': title.text,
      'amount': value,
    });

    title.clear();
    amount.clear();
    loadExpenses();
  }

  @override
  void initState() {
    super.initState();
    initDB();
  }

  @override
  void dispose() {
    title.dispose();
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(
                labelText: 'Expense Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: amount,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                prefixText: '₹ ',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addExpense,
              child: Text('Add Expense'),
            ),
            SizedBox(height: 15),

            // Display Total Expense
            Card(
              color: Colors.green.shade100,
              child: ListTile(
                title: Text('Total Expense'),
                trailing: Text(
                  '₹ ${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.money),
                      title: Text(expenses[index]['title']),
                      trailing: Text(
                        '₹ ${expenses[index]['amount']}',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
