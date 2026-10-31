// Write a Dart program to check whether a given number is even or odd. 
import 'dart:io'; 
void main() { 
    print("Enter a number:"); 
    int num = int.parse(stdin.readLineSync()!); 
    if (num % 2 == 0) { 
        print("The number is Even."); 
    } else { 
        print("The number is Odd."); 
} 
}