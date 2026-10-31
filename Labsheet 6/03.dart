// Write a Dart program to convert a Map into a JSON string and a JSON string back into a Map using the dart:convert library. 
import 'dart:convert';

void main() {
  Map student = {
    "name": "Manya",
    "roll": 101,
    "course": "BCA"
  };

  // Convert Map into JSON String
  String json = jsonEncode(student);
  print(json);

  // Convert JSON String back into Map
  Map data = jsonDecode(json);
  print(data);
}