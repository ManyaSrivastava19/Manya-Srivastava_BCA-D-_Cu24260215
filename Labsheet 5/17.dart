//  Develop a Student Record List Application in Flutter that allows the user to add a student (name, roll number, and course), displays all students in a list, supports searching by name, and allows deleting a student. 
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(home: App()),
);

class App extends StatefulWidget {
  @override
  State<App> createState() => _S();
}

class _S extends State<App> {
  final n = TextEditingController();
  final r = TextEditingController();
  final c = TextEditingController();
  final s = TextEditingController();

  List data = [];

  @override
  Widget build(BuildContext x) => Scaffold(
    appBar: AppBar(
      title: Text("Student Records"),
    ),

    body: Padding(
      padding: EdgeInsets.all(12),

      child: Column(
        children: [
          TextField(
            controller: n,
            decoration: InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 8),

          TextField(
            controller: r,
            decoration: InputDecoration(
              labelText: "Roll No",
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 8),

          TextField(
            controller: c,
            decoration: InputDecoration(
              labelText: "Course",
              border: OutlineInputBorder(),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              if (n.text.trim().isNotEmpty &&
                  r.text.trim().isNotEmpty &&
                  c.text.trim().isNotEmpty) {
                setState(() {
                  data.add([
                    n.text.trim(),
                    r.text.trim(),
                    c.text.trim()
                  ]);

                  n.clear();
                  r.clear();
                  c.clear();
                });
              }
            },
            child: Text("Add Student"),
          ),

          TextField(
            controller: s,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: "Search Student",
              prefixIcon: Icon(Icons.search),
            ),
          ),

          SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              itemCount: data.length,

              itemBuilder: (x, i) {
                if (!data[i][0]
                    .toLowerCase()
                    .contains(s.text.toLowerCase())) {
                  return SizedBox();
                }

                return ListTile(
                  title: Text(data[i][0]),

                  subtitle: Text(
                    "${data[i][1]} - ${data[i][2]}",
                  ),

                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),

                    onPressed: () {
                      setState(() {
                        data.removeAt(i);
                      });
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