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
