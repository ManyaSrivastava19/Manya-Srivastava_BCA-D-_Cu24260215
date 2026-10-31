// Create a Flutter application to convert API data into objects using a model class with a fromJson() method and display the objects on the screen.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Model Class
class User {
  int id;
  String name;
  String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  // Convert JSON into Object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserScreen(),
  ));
}

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<User> users = [];
  bool isLoading = true;

  Future<void> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        setState(() {
          users = data.map((json) => User.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Objects'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : users.isEmpty
              ? Center(child: Text('Unable to load users'))
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    User user = users[index];

                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(user.name[0]),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.email),
                        trailing: Text('ID: ${user.id}'),
                      ),
                    );
                  },
                ),
    );
  }
}