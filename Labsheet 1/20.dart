// Write a Dart program to reverse a given number using a loop. 
import 'dart:io';

void main() {
  print("Enter a number:");
  int num = int.parse(stdin.readLineSync()!);

  int reverse = 0;

  while (num != 0) {
    int digit = num % 10;
    reverse = reverse * 10 + digit;
    num ~/= 10;
  }

  print("Reversed number: $reverse");
}