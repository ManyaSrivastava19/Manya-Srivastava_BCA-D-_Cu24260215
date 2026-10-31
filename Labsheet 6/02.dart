// Write a Dart program to convert a Student object into a Map and a Map back into a Student object using toMap() and fromMap() methods. 
class Student {
  String name;
  int roll;
  String course;

  Student(this.name, this.roll, this.course);

  // Convert Student object into Map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "roll": roll,
      "course": course
    };
  }

  // Convert Map into Student object
  factory Student.fromMap(Map<String, dynamic> m) {
    return Student(
      m["name"],
      m["roll"],
      m["course"]
    );
  }
}

void main() {
  var s = Student("Mohit", 101, "BCA");

  Map<String, dynamic> m = s.toMap();
  print(m);

  var s2 = Student.fromMap(m);
  print("${s2.name} ${s2.roll} ${s2.course}");
}