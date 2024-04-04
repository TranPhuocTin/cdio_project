import 'package:cdio_project/model/student/faculty.dart';

class Topic {
  final int topicId;
  final String name;
  final String introduce;
  final String image;
  final String content;
  final int deleteFlag;
  final Faculty faculty;

  Topic({
    required this.topicId,
    required this.name,
    required this.introduce,
    required this.image,
    required this.content,
    required this.deleteFlag,
    required this.faculty,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      topicId: json['topicId'],
      name: json['name'],
      introduce: json['introduce'],
      image: json['image'],
      content: json['content'],
      deleteFlag: json['deleteFlag'],
      faculty: Faculty.fromJson(json['faculty']),
    );
  }
}