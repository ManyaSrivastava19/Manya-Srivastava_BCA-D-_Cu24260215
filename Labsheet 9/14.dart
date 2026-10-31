// Create a Flutter application to send data to a REST API using http.post() from a form (title and body) and display the response message. 
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PostScreen(),
  ));
}

class PostScreen extends StatefulWidget {
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  String message = '';
  bool isLoading = false;

  Future<void> sendData() async {
    if (titleController.text.isEmpty ||
        bodyController.text.isEmpty) {
      setState(() {
        message = 'Please fill all fields';
      });
      return;
    }

    setState(() {
      isLoading = true;
      message = '';
    });

    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': titleController.text,
          'body': bodyController.text,
          'userId': 1,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);

        setState(() {
          message = 'Data submitted successfully!\n'
              'Post ID: ${data['id']}';
        });
      } else {
        setState(() {
          message = 'Failed to submit data';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error: Unable to connect to API';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POST API Example'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Enter Title',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: bodyController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Enter Body',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: isLoading ? null : sendData,
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Submit'),
            ),

            SizedBox(height: 20),

            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}