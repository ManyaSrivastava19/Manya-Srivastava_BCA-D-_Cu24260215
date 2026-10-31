//Create a list of numbers and find the largest and smallest number from the list. 
void main() {
  List<int> numbers = [10, 25, 5, 40, 15];

  int largest = numbers[0];
  int smallest = numbers[0];

  for (int num in numbers) {
    if (num > largest) {
      largest = num;
    }

    if (num < smallest) {
      smallest = num;
    }
  }

  print("Largest number: $largest");
  print("Smallest number: $smallest");
}