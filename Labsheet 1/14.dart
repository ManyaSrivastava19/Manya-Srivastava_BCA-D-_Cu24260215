// Write a Dart program to calculate grades based on the percentage obtained by a student. 
import 'dart:io';

void main() {
  print("Enter percentage:");
  double percentage = double.parse(stdin.readLineSync()!);

  if (percentage >= 90) {
    print("Grade: A+");
  } else if (percentage >= 80) {
    print("Grade: A");
  } else if (percentage >= 70) {
    print("Grade: B");
  } else if (percentage >= 60) {
    print("Grade: C");
  } else if (percentage >= 50) {
    print("Grade: D");
  } else {
    print("Grade: F");
  }
}