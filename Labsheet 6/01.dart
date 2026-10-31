//  Write a Dart program to store student details (name, roll number, and course) in a Map and display all key-value pairs. 
void main() {
  Map student = {
    "Name": "Manya",
    "Roll No": 101,
    "Course": "BCA"
  };

  student.forEach((key, value) {
    print("$key: $value");
  });
}