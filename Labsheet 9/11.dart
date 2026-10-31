// Create a Flutter application to display a list of users fetched from an API and open a Detail screen showing the complete details of the selected user. 
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserListScreen(),
  ));
}

// User Model
class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final Map<String, dynamic> address;
  final Map<String, dynamic> company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      address: json['address'],
      company: json['company'],
    );
  }
}

// User List Screen
class UserListScreen extends StatefulWidget {
  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> users = [];
  bool isLoading = true;
  String error = '';

  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        setState(() {
          users = data.map((e) => User.fromJson(e)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      setState(() {
        error = 'Unable to fetch users. Please try again.';
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
        title: Text('User List'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(error),
                      ElevatedButton(
                        onPressed: fetchUsers,
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
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
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UserDetailScreen(user: user),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}

// User Detail Screen
class UserDetailScreen extends StatelessWidget {
  final User user;

  UserDetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                user.name[0],
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(height: 20),
            detail('ID', user.id.toString()),
            detail('Name', user.name),
            detail('Username', user.username),
            detail('Email', user.email),
            detail('Phone', user.phone),
            detail('Website', user.website),
            detail('Address',
                '${user.address['street']}, ${user.address['city']}, ${user.address['zipcode']}'),
            detail('Company', user.company['name']),
          ],
        ),
      ),
    );
  }

  Widget detail(String title, String value) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}