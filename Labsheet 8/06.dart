// Extend the Contact Book application to delete a contact after confirmation using an AlertDialog.

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
    loadContacts();
  }

  Future<void> deleteContact(int id) async {
    await db!.delete(
      'Contacts',
      where: 'id = ?',
      whereArgs: [id],
    );

    loadContacts();
  }

  void confirmDelete(int id, String contactName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Contact'),
          content: Text(
            'Are you sure you want to delete $contactName?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                deleteContact(id);
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
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
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];

                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(contact['name']),
                      subtitle: Text(contact['phone']),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          confirmDelete(
                            contact['id'],
                            contact['name'],
                          );
                        },
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
