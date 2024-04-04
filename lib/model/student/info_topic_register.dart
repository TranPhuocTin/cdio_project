import 'package:cdio_project/model/student/topic.dart';

class InfoTopicRegister {
  final int infoTopicRegisterId;
  final bool status;
  final bool statusComplete;
  final bool topicCancel;
  final String descriptionURL;
  final Topic topic;
  final int groupAccount;
  final dynamic teacher; // Change the type accordingly
  final List<dynamic> processList; // Change the type accordingly

  InfoTopicRegister({
    required this.infoTopicRegisterId,
    required this.status,
    required this.statusComplete,
    required this.topicCancel,
    required this.descriptionURL,
    required this.topic,
    required this.groupAccount,
    required this.teacher,
    required this.processList,
  });

  factory InfoTopicRegister.fromJson(Map<String, dynamic> json) {
    return InfoTopicRegister(
      infoTopicRegisterId: json['infoTopicRegisterId'],
      status: json['status'],
      statusComplete: json['statusComplete'],
      topicCancel: json['topicCancel'],
      descriptionURL: json['descriptionURL'],
      topic: Topic.fromJson(json['topic']),
      groupAccount: json['groupAccount'],
      teacher: json['teacher'], // Change the type accordingly
      processList: json['processList'], // Change the type accordingly
    );
  }
}

