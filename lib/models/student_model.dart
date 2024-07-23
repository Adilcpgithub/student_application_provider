import 'package:hive/hive.dart';

part 'student_model.g.dart';

@HiveType(typeId: 0)
class Student {
  @HiveField(0)
  String name;
  @HiveField(1)
  String age;
  @HiveField(3)
  String studentClass;
  @HiveField(4)
  String gender;
  @HiveField(5)
  String? imagePath;
  Student(
      {required this.name,
      required this.age,
      required this.studentClass,
      required this.gender,
      this.imagePath});
}
