// Write a Dart function to check whether a given number is prime or not. 
import 'dart:io';

bool isPrime(int num) {
  if (num < 2) {
    return false;
  }

  for (int i = 2; i <= num ~/ 2; i++) {
    if (num % i == 0) {
      return false;
    }
  }

  return true;
}

void main() {
  print("Enter a number:");
  int num = int.parse(stdin.readLineSync()!);

  if (isPrime(num)) {
    print("$num is a Prime Number.");
  } else {
    print("$num is not a Prime Number.");
  }
}