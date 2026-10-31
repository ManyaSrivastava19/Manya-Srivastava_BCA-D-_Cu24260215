// Extend the Contact Book application to search contacts by name using the LIKE operator. 

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ContactApp(),
  ));
}

class ContactApp extends StatefulWidget {
  @override
  State<ContactApp> createState() => _ContactAppState();
}

class _ContactAppState extends State<ContactApp> {
  Database? db;
  List<Map<String, dynamic>> contacts = [];

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController search = TextEditingController();

  Future<void> initDB() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'contacts.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT)',
        );
      },
    );
    loadContacts();
  }

  Future<void> loadContacts() async {
    contacts = await db!.query('Contacts', orderBy: 'id DESC');
    setState(() {});
  }

  Future<void> addContact() async {
    if (name.text.isEmpty || phone.text.isEmpty) return;

    await db!.insert('Contacts', {
      'name': name.text,
      'phone': phone.text,
    });

    name.clear();
    phone.clear();
    search.clear();
    loadContacts();
  }

  Future<void> searchContacts(String value) async {
    contacts = await db!.query(
      'Contacts',
      where: 'name LIKE ?',
      whereArgs: ['%$value%'],
      orderBy: 'id DESC',
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initDB();
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Book'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                labelText: 'Enter Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Enter Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addContact,
              child: Text('Add Contact'),
            ),
            SizedBox(height: 15),
            TextField(
              controller: search,
              onChanged: searchContacts,
              decoration: InputDecoration(
                labelText: 'Search Contact by Name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(contacts[index]['name']),
                      subtitle: Text(contacts[index]['phone']),
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
