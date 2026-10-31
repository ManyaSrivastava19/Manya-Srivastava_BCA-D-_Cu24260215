// Write a Dart program to calculate the factorial of a given number. 
import 'dart:io';

void main() {
  print("Enter a number:");
  int num = int.parse(stdin.readLineSync()!);

  int factorial = 1;

  for (int i = 1; i <= num; i++) {
    factorial = factorial * i;
  }

  print("Factorial of $num: $factorial");
}