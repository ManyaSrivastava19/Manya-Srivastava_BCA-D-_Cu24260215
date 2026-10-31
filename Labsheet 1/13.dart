// Write a Dart program to check whether a given year is a leap year. 
import 'dart:io';

void main() {
  print("Enter a year:");
  int year = int.parse(stdin.readLineSync()!);

  if ((year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)) {
    print("$year is a Leap Year.");
  } else {
    print("$year is not a Leap Year.");
  }
}