import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Semester {
  final String id;
  final String name;

  Semester({required this.id, required this.name});
}
