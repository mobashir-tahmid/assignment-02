// A. Define an abstract class named Role:
abstract class Role {
  void displayRole();
}k

// B. Create an abstract class Person:
abstract class Person implements Role {
  String name;
  int age;
  String address;

  Person(this.name, this.age, this.address);

  // Implement the Role interface methods
  @override
  void displayRole() {
    // Do nothing, to be implemented by subclasses
  }
}

// C. Create a class Student that extends Person:
class Student extends Person {
  int studentID;
  String grade;
  List<double> courseScores = [];

  Student(String name, int age, String address, this.studentID, this.grade)
      : super(name, age, address);

  // Override the displayRole() method
  @override
  void displayRole() {
    print("Role: Student");
  }

  double calculateAverageScore() {
    if (courseScores.isEmpty) return 0.0;

    double sum = courseScores.reduce((a, b) => a + b);
    return sum / courseScores.length;
  }
}

// D. Create another class Teacher that extends Person:
class Teacher extends Person {
  int teacherID;
  List<String> coursesTaught = [];

  Teacher(String name, int age, String address, this.teacherID, this.coursesTaught)
      : super(name, age, address);

  // Override the displayRole() method
  @override
  void displayRole() {
    print("Role: Teacher");
  }

  void displayCoursesTaught() {
    print("Courses Taught:");
    for (var course in coursesTaught) {
      print("- $course");
    }
  }
}

// E. Create a class StudentManagementSystem:
void main() {
  // In the main method, create instances of Student and Teacher classes.
  var student = Student("John Doe", 20, "123 Main St", 12345, "Sophomore")
    ..courseScores.addAll([90, 85,92]);

  var teacher = Teacher("Mrs. Smith", 35, "456 Oak St", 56789, ["Math"  , "English", "Bangla"]);

  // Set the attributes using appropriate methods.
  // Display the role of each person.
  print("Student Information:");
  student.displayRole();
  print("Name: ${student.name}");
  print("Age: ${student.age}");
  print("Address: ${student.address}");
  print("Average Score: ${student.calculateAverageScore()}");
  print("");

  print("Teacher Information:");
  teacher.displayRole();
  print("Name: ${teacher.name}");
  print("Age: ${teacher.age}");
  print("Address: ${teacher.address}");
  teacher.displayCoursesTaught();
}


