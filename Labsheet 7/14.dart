// Create a Flutter application to display the total number of records in the students table. 
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count = 0;

  Future<Database> getDB() async {
    String path = join(await getDatabasesPath(), 'student.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            rollNumber INTEGER,
            course TEXT
          )
        ''');
      },
    );
  }

  Future<void> getCount() async {
    Database db = await getDB();

    List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT(*) AS total FROM Students');

    setState(() {
      count = result[0]['total'];
    });
  }

  @override
  void initState() {
    super.initState();
    getCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Total Student Records")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Total Students: $count",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getCount,
              child: Text("Count Students"),
            ),
          ],
        ),
      ),
    );
  }
}