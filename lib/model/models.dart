class CourseModel {
  final String id;
  final String name;
  final String code;
  final String teacherId;
  final List<String> studentIds; // students enrolled
  final String semesterId;

  CourseModel({
    required this.id,
    required this.name,
    required this.code,
    required this.teacherId,
    required this.studentIds,
    required this.semesterId,
  });

  CourseModel copyWith({
    String? id,
    String? name,
    String? code,
    String? teacherId,
    List<String>? studentIds,
    String? semesterId,
  }) {
    return CourseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      teacherId: teacherId ?? this.teacherId,
      studentIds: studentIds ?? this.studentIds,
      semesterId: semesterId ?? this.semesterId,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'code': code,
    'teacherId': teacherId,
    'studentIds': studentIds,
    'semesterId': semesterId,
  };

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    id: json['id'],
    name: json['name'],
    code: json['code'],
    teacherId: json['teacherId'],
    studentIds: List<String>.from(json['studentIds']),
    semesterId: json['semesterId'],
  );
}

class SemesterModel {
  final String id;
  final String name;

  SemesterModel({required this.id, required this.name});

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  factory SemesterModel.fromJson(Map<String, dynamic> json) =>
      SemesterModel(id: json['id'], name: json['name']);
}

class AttendanceRecord {
  final String id;
  final String courseId;
  final String studentId;
  final DateTime date;
  final bool isPresent;

  AttendanceRecord({
    required this.id,
    required this.courseId,
    required this.studentId,
    required this.date,
    required this.isPresent,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'courseId': courseId,
    'studentId': studentId,
    'date': date.toIso8601String(),
    'isPresent': isPresent,
  };

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) =>
      AttendanceRecord(
        id: json['id'],
        courseId: json['courseId'],
        studentId: json['studentId'],
        date: DateTime.parse(json['date']),
        isPresent: json['isPresent'],
      );
}
