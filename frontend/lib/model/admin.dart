import 'package:classattendanceportal/model/app_user.dart';

class Admin extends AppUser {
  Admin({
    required super.id,
    required super.name,
    required super.email,
    required super.password,
    required super.department,
    required super.faculty,
    required super.role,
  }) {}
}
