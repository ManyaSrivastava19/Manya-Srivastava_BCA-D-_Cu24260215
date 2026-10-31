// Create a Flutter application to fetch data from a public REST API using http.get() and display the response body on the screen.
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ApiScreen(),
    );
  }
}

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  String responseBody = 'Click button to fetch data';
  bool loading = false;

  Future<void> fetchData() async {
    setState(() {
      loading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );

      if (response.statusCode == 200) {
        setState(() {
          responseBody = response.body;
        });
      } else {
        setState(() {
          responseBody = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        responseBody = 'Failed to fetch data: $e';
      });
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Data'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: loading ? null : fetchData,
              child: const Text('Fetch Data'),
            ),
            const SizedBox(height: 15),
            if (loading)
              const CircularProgressIndicator(),
            Expanded(
              child: SingleChildScrollView(
                child: SelectableText(responseBody),
              ),
            ),
          ],
        ),
      ),
    );
  }
}