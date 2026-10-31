// Write a Dart program to calculate the area and perimeter of a rectangle
import 'dart:io';

void main() {
  print("Enter length of rectangle:");
  double length = double.parse(stdin.readLineSync()!);

  print("Enter width of rectangle:");
  double width = double.parse(stdin.readLineSync()!);

  double area = length * width;
  double perimeter = 2 * (length + width);

  print("Area of Rectangle: $area");
  print("Perimeter of Rectangle: $perimeter");
}