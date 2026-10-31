// Create a Flutter application to filter a list of data fetched from an API using a search TextField. 
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserScreen(),
  ));
}

// User Model
class User {
  String name;
  String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
    );
  }
}

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<User> users = [];
  List<User> filteredUsers = [];

  bool isLoading = true;

  Future<void> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        setState(() {
          users = data.map((e) => User.fromJson(e)).toList();
          filteredUsers = users;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Search Function
  void searchUsers(String query) {
    setState(() {
      filteredUsers = users
          .where((user) =>
              user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
        title: Text('Search Users'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              onChanged: searchUsers,
              decoration: InputDecoration(
                hintText: 'Search user by name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : filteredUsers.isEmpty
                    ? Center(child: Text('No users found'))
                    : ListView.builder(
                        itemCount: filteredUsers.length,
                        itemBuilder: (context, index) {
                          User user = filteredUsers[index];

                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(user.name[0]),
                              ),
                              title: Text(user.name),
                              subtitle: Text(user.email),
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