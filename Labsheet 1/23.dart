//  Create a list of five student names and display each name using a loop. 
void main() {
  List<String> students = [
    "Manya",
    "Neha",
    "Ruhi",
    "Priya",
    "Riya"
  ];

  for (String name in students) {
    print(name);
  }
}