import 'package:classattendanceportal/enums/credits.dart';
import 'package:classattendanceportal/model/teacher.dart';

class Course {
  Credits credits;
  String name;
  String code;
  String id;
  Teacher teacher;

  Course({
    required this.credits,
    required this.name,
    required this.code,
    required this.id,
    required this.teacher,
  }) {}
}
