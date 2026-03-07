import 'package:classattendanceportal/model/app_user.dart';

class Student extends AppUser {
  String studentId;

  Student({
    required super.id,
    required super.name,
    required super.email,
    required super.password,
    required super.department,
    required super.faculty,
    required super.role,
    required this.studentId,
  }) {}
}
