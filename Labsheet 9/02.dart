// Write a Dart program to demonstrate Future, async, and await using a function that returns a value after a delay. 
Future<String> getData() async {
  await Future.delayed(Duration(seconds: 3));
  return "Data Loaded Successfully";
}

void main() async {
  print("Fetching Data...");

  String result = await getData();

  print(result);
  print("Program Completed");
}