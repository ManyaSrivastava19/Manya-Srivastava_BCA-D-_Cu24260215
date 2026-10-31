// Write a Dart program to parse a JSON array of students into a List of Student objects using a fromJson() factory constructor.
import 'dart:convert';

class Student {
  int id;
  String name;
  String course;

  Student({
    required this.id,
    required this.name,
    required this.course,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      course: json['course'],
    );
  }
}

void main() {
  String jsonData = '''
  [
    {"id": 1, "name": "Mohit", "course": "BCA"},
    {"id": 2, "name": "Rahul", "course": "BBA"},
    {"id": 3, "name": "Aman", "course": "BCA"}
  ]
  ''';

  List<dynamic> data = jsonDecode(jsonData);

  List<Student> students =
      data.map((item) => Student.fromJson(item)).toList();

  for (var student in students) {
    print('ID: ${student.id}');
    print('Name: ${student.name}');
    print('Course: ${student.course}');
    print('----------------');
  }
}