import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_application_provider/models/student_model.dart';

class StudentProvider extends ChangeNotifier {
  bool _isCheck = false;
  bool get isCheck => _isCheck;
  showSearch() {
    _isCheck = !_isCheck;
    notifyListeners();
    print(_isCheck);
  }

  List<Student> _students = [];
  List<Student> _filteredStudents = [];

  List<Student> get students => _students;
  List<Student> get filteredStudents => _filteredStudents;

  StudentProvider() {
    loadStudents();
  }

  void loadStudents() {
    var box = Hive.box<Student>('students');
    _students = box.values.toList();
    _filteredStudents = _students;
    notifyListeners();
  }

  dynamic getStudentKey(int index) {
    var box = Hive.box<Student>('students');
    return box.keyAt(index); // Return the key for the specific index
  }

  void addStudent(Student student) {
    var box = Hive.box<Student>('students');
    box.add(student);
    _students.add(student);
    _filteredStudents = _students;
    notifyListeners();
  }

  void updateStudent(int index, Student student) {
    var box = Hive.box<Student>('students');
    box.putAt(index, student);
    _students[index] = student;
    _filteredStudents = _students;
    notifyListeners();
  }

  Student? getStudentFromKey(int key) {
    var box = Hive.box<Student>('students');
    return box.getAt(key);
  }

  void deleteStudentByKey(dynamic key) {
    var box = Hive.box<Student>('students');
    box.delete(key);
    loadStudents(); // Reload students to update the list
  }

  void searchStudents(String query) {
    if (query.isEmpty) {
      _filteredStudents = _students; // Show all students if query is empty
    } else {
      var lowercaseQuery = query.toLowerCase();
      _filteredStudents = _students
          .where(
              (student) => student.name.toLowerCase().contains(lowercaseQuery))
          .toList(); // Filter students by name
    }
    notifyListeners();
  }
}
