// Write a Dart program to swap the values of two variables. 
void main() {
  int a = 10;
  int b = 20;

  print("Before Swapping:");
  print("a = $a");
  print("b = $b");

  int temp = a;
  a = b;
  b = temp;

  print("After Swapping:");
  print("a = $a");
  print("b = $b");
}