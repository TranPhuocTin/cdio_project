import 'package:cdio_project/model/student/faculty.dart';

class Grade {
  final int gradeId;
  final String name;
  final Faculty faculty;

  Grade({
    required this.gradeId,
    required this.name,
    required this.faculty,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      gradeId: json['gradeId'],
      name: json['name'],
      faculty: Faculty.fromJson(json['faculty']),
    );
  }
}
