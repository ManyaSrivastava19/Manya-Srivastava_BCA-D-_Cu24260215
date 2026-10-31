
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TodoApp(),
  ));
}

class TodoApp extends StatefulWidget {
  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  Database? db;
  List<Map<String, dynamic>> tasks = [];

  TextEditingController taskController = TextEditingController();

  Future<void> initDB() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT, completed INTEGER)',
        );
      },
    );
    loadTasks();
  }

  Future<void> loadTasks() async {
    tasks = await db!.query('Tasks', orderBy: 'id DESC');
    setState(() {});
  }

  Future<void> addTask() async {
    if (taskController.text.isEmpty) return;

    await db!.insert('Tasks', {
      'task': taskController.text,
      'completed': 0,
    });

    taskController.clear();
    loadTasks();
  }

  Future<void> updateStatus(int id, bool value) async {
    await db!.update(
      'Tasks',
      {'completed': value ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );

    loadTasks();
  }

  @override
  void initState() {
    super.initState();
    initDB();
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do App'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Enter Task',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: addTask,
              child: Text('Add Task'),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  bool isCompleted = task['completed'] == 1;

                  return Card(
                    child: CheckboxListTile(
                      title: Text(
                        task['task'],
                        style: TextStyle(
                          decoration: isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      value: isCompleted,
                      onChanged: (value) {
                        updateStatus(task['id'], value!);
                      },
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
