// Develop a Student Management Application in Flutter using Firebase Authentication and Cloud Firestore in which a registered user can log in and add, view, update, and delete student records.
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthWrapper(),
    );
  }
}

// Check authentication state
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return StudentScreen();
        }

        return AuthScreen();
      },
    );
  }
}

// Login and Registration Screen
class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLogin = true;
  bool isLoading = false;

  Future<void> authenticate() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showMessage('Please enter email and password!');
      return;
    }

    setState(() => isLoading = true);

    try {
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message = 'Email is already registered!';
          break;
        case 'weak-password':
          message = 'Password must be stronger!';
          break;
        case 'invalid-email':
          message = 'Invalid email address!';
          break;
        case 'invalid-credential':
          message = 'Invalid email or password!';
          break;
        case 'user-not-found':
          message = 'User not found!';
          break;
        default:
          message = e.message ?? 'Authentication failed!';
      }

      showMessage(message);
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Management'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              size: 75,
              color: Colors.blue,
            ),

            SizedBox(height: 20),

            Text(
              isLogin ? 'User Login' : 'User Registration',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: isLoading ? null : authenticate,
              child: Text(
                isLoading
                    ? 'Please wait...'
                    : isLogin
                        ? 'Login'
                        : 'Register',
              ),
            ),

            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(
                isLogin
                    ? 'Create New Account'
                    : 'Already registered? Login',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Student Management Screen
class StudentScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final rollController = TextEditingController();
  final courseController = TextEditingController();

  // Get current user's student collection
  CollectionReference<Map<String, dynamic>> get studentCollection {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('students');
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Add or Update Student
  Future<void> showStudentDialog(
    BuildContext context, {
    String? documentId,
    String? oldName,
    String? oldRoll,
    String? oldCourse,
  }) async {
    nameController.text = oldName ?? '';
    rollController.text = oldRoll ?? '';
    courseController.text = oldCourse ?? '';

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            documentId == null ? 'Add Student' : 'Update Student',
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Student Name',
                  ),
                ),

                TextField(
                  controller: rollController,
                  decoration: InputDecoration(
                    labelText: 'Roll Number',
                  ),
                ),

                TextField(
                  controller: courseController,
                  decoration: InputDecoration(
                    labelText: 'Course',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () async {
                String name = nameController.text.trim();
                String roll = rollController.text.trim();
                String course = courseController.text.trim();

                if (name.isEmpty ||
                    roll.isEmpty ||
                    course.isEmpty) {
                  showMessage(context, 'Please fill all fields!');
                  return;
                }

                try {
                  final data = {
                    'name': name,
                    'rollNumber': roll,
                    'course': course,
                  };

                  if (documentId == null) {
                    await studentCollection.add(data);
                  } else {
                    await studentCollection
                        .doc(documentId)
                        .update(data);
                  }

                  if (!context.mounted) return;

                  Navigator.pop(dialogContext);

                  showMessage(
                    context,
                    documentId == null
                        ? 'Student added successfully!'
                        : 'Student updated successfully!',
                  );
                } catch (e) {
                  showMessage(context, 'Operation failed!');
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Delete Student
  Future<void> deleteStudent(
    BuildContext context,
    String documentId,
  ) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Delete Student'),
          content: Text(
            'Are you sure you want to delete this record?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    try {
      await studentCollection.doc(documentId).delete();

      if (context.mounted) {
        showMessage(context, 'Student deleted successfully!');
      }
    } catch (e) {
      if (context.mounted) {
        showMessage(context, 'Error deleting student!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Student Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Logged in: ${user?.email ?? ''}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: studentCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error loading student records!'),
                  );
                }

                if (!snapshot.hasData ||
                    snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No student records found!'),
                  );
                }

                final students = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final doc = students[index];
                    final student = doc.data();

                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            (student['name'] ?? '?')[0]
                                .toString()
                                .toUpperCase(),
                          ),
                        ),

                        title: Text(student['name'] ?? ''),
                        subtitle: Text(
                          'Roll No: ${student['rollNumber'] ?? ''}\n'
                          'Course: ${student['course'] ?? ''}',
                        ),
                        isThreeLine: true,

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                showStudentDialog(
                                  context,
                                  documentId: doc.id,
                                  oldName: student['name'],
                                  oldRoll: student['rollNumber'],
                                  oldCourse: student['course'],
                                );
                              },
                            ),

                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                deleteStudent(context, doc.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => showStudentDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}