// Write a Dart program to calculate the area of a circle. 
import 'dart:io'; 
void main() { 
    print("Enter radius of circle:"); 
    double radius = double.parse(stdin.readLineSync()!); 
    double area = 3.14159 * radius * radius; 
    print("Area of Circle: $area"); 
} 