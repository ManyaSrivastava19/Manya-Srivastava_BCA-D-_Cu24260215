//  Write a Dart function that accepts two numbers and returns their sum. 
import 'dart:io';

int addNumbers(int a, int b) {
  return a + b;
}

void main() {
  print("Enter first number:");
  int num1 = int.parse(stdin.readLineSync()!);

  print("Enter second number:");
  int num2 = int.parse(stdin.readLineSync()!);

  int result = addNumbers(num1, num2);

  print("Sum: $result");
}