//Develop a Student Result Program in Dart that stores the student's name and marks in three subjects, calculates total marks and percentage, and displays the result as Pass or Fail. 
import 'dart:io';

void main() {
  print("Enter student name:");
  String name = stdin.readLineSync()!;

  print("Enter marks in Subject 1:");
  double marks1 = double.parse(stdin.readLineSync()!);

  print("Enter marks in Subject 2:");
  double marks2 = double.parse(stdin.readLineSync()!);

  print("Enter marks in Subject 3:");
  double marks3 = double.parse(stdin.readLineSync()!);

  double total = marks1 + marks2 + marks3;
  double percentage = (total / 300) * 100;

  print("\nStudent Name: $name");
  print("Total Marks: $total");
  print("Percentage: $percentage%");

  if (percentage >= 40) {
    print("Result: Pass");
  } else {
    print("Result: Fail");
  }
}