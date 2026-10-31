// Create a Flutter Expense Tracker application that stores expenses (title and amount) in an SQLite database and displays them in a list. 

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
    setState(() {});
  }

  Future<void> addExpense() async {
    if (title.text.isEmpty || amount.text.isEmpty) return;

    await db!.insert('Expenses', {
      'title': title.text,
      'amount': double.tryParse(amount.text) ?? 0.0,
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
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
