
class Student {
  final int studentId;
  final String name;
  final String dateOfBirth;
  final String address;
  final String phone;
  final String email;
  final String avatar;
  final bool gender;
  final bool deleteFlag;
  final bool statusJoin;
  GroupAccount? groupAccount;

  Student({
    required this.studentId,
    required this.name,
    required this.dateOfBirth,
    required this.address,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.gender,
    required this.deleteFlag,
    required this.statusJoin,
    this.groupAccount,
  });

  factory Student.fromJson(Map<String, dynamic> jsons) {
    return Student(
      studentId: jsons['studentId'] as int,
      name: jsons['name'] as String,
      dateOfBirth: jsons['dateOfBirth'] as String,
      address: jsons['address'] as String,
      phone: jsons['phone'] as String,
      email: jsons['email'] as String,
      avatar: jsons['avatar'] as String,
      gender: jsons['gender'] as bool,
      deleteFlag: jsons['delete_flag'] as bool,
      statusJoin: jsons['status_join'],
      //Fix lỗi int is not a subtype of Map<String, dynamic>
      groupAccount: jsons['groupAccount'] is Map<String, dynamic> ? GroupAccount.fromJson(jsons['groupAccount']) : null,
    );
  }
}

class GroupStudent {
  final int studentId;
  final String name;
  final String dateOfBirth;
  final String address;
  final String phone;
  final String email;
  final String avatar;
  final bool gender;

  GroupStudent({
    required this.studentId,
    required this.name,
    required this.dateOfBirth,
    required this.address,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.gender,
  });

  factory GroupStudent.fromJson(Map<String, dynamic> jsons) {
    return GroupStudent(
      studentId: jsons['studentId'],
      name: jsons['name'],
      dateOfBirth: jsons['dateOfBirth'],
      address: jsons['address'],
      phone: jsons['phone'],
      email: jsons['email'],
      avatar: jsons['avatar'],
      gender: jsons['gender'],
    );
  }
}

class GroupAccount {
  int? groupAccountId;
  String? name;
  bool? deleteFlag;
  bool? status;
  String? date;
  List<GroupStudent>? studentList;  
  // final InfoTopicRegister infoTopicRegister;
  List<InfoTopicRegister> ?infoTopicRegisterList;

  GroupAccount({
    this.groupAccountId,
    this.name,
    this.deleteFlag,
    this.status,
    this.date,
    this.studentList,

    // required this.infoTopicRegister,
    required this.infoTopicRegisterList,
  });

  GroupAccount.fromJson(Map<String, dynamic> json) {
    groupAccountId = json['groupAccountId'] as int;
    name = json['name'] as String;
    deleteFlag = json['delete_flag'] as bool;
    status = json['status'] as bool;
    date = json['date'] as String;
    if (json['studentList'] != null) {
      studentList = <GroupStudent>[];
      for (var element in (json['studentList'] as List) ) {
        studentList!.add(GroupStudent.fromJson(element));
      }
    }
    if(json['infoTopicRegisterList'] != null) {
      infoTopicRegisterList = <InfoTopicRegister>[];
      for (var element in (json['infoTopicRegisterList'] as List)) {
        infoTopicRegisterList!.add(InfoTopicRegister.fromJson(element));
      }
    }
  }
}

class InfoTopicRegister {
  final int infoTopicRegisterId;
  final bool status;
  final bool statusComplete;
  final bool topicCancel;
  final String descriptionURL;
  final Topic topic;
  final int groupAccount;
  final dynamic teacher;
  final List<dynamic> processList;

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
      teacher: json['teacher'],
      processList: json['processList'],
    );
  }
}

class Topic {
  final int topicId;
  final String name;
  final String introduce;
  final String image;
  final String content;
  final int deleteFlag;

  Topic({
    required this.topicId,
    required this.name,
    required this.introduce,
    required this.image,
    required this.content,
    required this.deleteFlag,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      topicId: json['topicId'],
      name: json['name'],
      introduce: json['introduce'],
      image: json['image'],
      content: json['content'],
      deleteFlag: json['deleteFlag'],
    );
  }
}
