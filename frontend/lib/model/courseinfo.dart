import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CourseInfo {
  final String id;
  final String name;
  final String code;
  final String teacherId;
  final List<String> studentIds;
  final String semesterId;

  CourseInfo({
    required this.id,
    required this.name,
    required this.code,
    required this.teacherId,
    required this.studentIds,
    required this.semesterId,
  });
}
