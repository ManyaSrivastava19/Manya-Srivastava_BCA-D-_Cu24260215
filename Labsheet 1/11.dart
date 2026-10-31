// Write a Dart program to find the largest of two numbers. 
import 'dart:io';

void main() {
  print("Enter first number:");
  int num1 = int.parse(stdin.readLineSync()!);

  print("Enter second number:");
  int num2 = int.parse(stdin.readLineSync()!);

  if (num1 > num2) {
    print("Largest number: $num1");
  } else if (num2 > num1) {
    print("Largest number: $num2");
  } else {
    print("Both numbers are equal.");
  }
}