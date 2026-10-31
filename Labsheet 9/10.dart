// Create a Flutter application to handle API errors (no internet connection or invalid response status code) and display an error message with a Retry button.
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ApiScreen(),
  ));
}

class ApiScreen extends StatefulWidget {
  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  List users = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'))
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        setState(() {
          users = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'No internet connection or API error!';
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
        title: Text('API Error Handling'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : errorMessage.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 60),
                      SizedBox(height: 10),
                      Text(errorMessage),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: fetchUsers,
                        child: Text('Retry'),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(users[index]['name'][0]),
                        ),
                        title: Text(users[index]['name']),
                        subtitle: Text(users[index]['email']),
                      );
                    },
                  ),
      ),
    );
  }
}