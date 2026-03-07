import 'package:classattendanceportal/enums/department.dart';
import 'package:classattendanceportal/enums/faculty.dart';
import 'package:classattendanceportal/enums/user_role.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AppUser {
  final String id;
  final String name;
  final String email;
  final String password;
  final UserRole role;
  final Department department;
  final Faculty faculty;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.department,
    required this.faculty,
  });
}
