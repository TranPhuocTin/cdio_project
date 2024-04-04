// import 'package:cdio_project/model/student/info_topic_register.dart';
// import 'package:cdio_project/model/student/student.dart';

// class   GroupAccount {
//   final int groupAccountId;
//   final String name;
//   final bool deleteFlag;
//   final bool status;
//   final String date;
//   final List<Student> studentList;
//   final List<InfoTopicRegister> infoTopicRegisterList;

//   GroupAccount({
//     required this.groupAccountId,
//     required this.name,
//     required this.deleteFlag,
//     required this.status,
//     required this.date,
//     required this.studentList,
//     required this.infoTopicRegisterList,
//   });

//   factory GroupAccount.fromJson(Map<String, dynamic> json) {
//     var studentList = <Student>[];
//     var infoTopicRegisterList = <InfoTopicRegister>[];

//     if (json['studentList'] != null) {
//       json['studentList'].forEach((v) {
//         studentList.add(Student.fromJson(v));
//       });
//     }

//     if (json['infoTopicRegisterList'] != null) {
//       json['infoTopicRegisterList'].forEach((v) {
//         infoTopicRegisterList.add(InfoTopicRegister.fromJson(v));
//       });
//     }

//     return GroupAccount(
//       groupAccountId: json['groupAccountId'],
//       name: json['name'],
//       deleteFlag: json['delete_flag'],
//       status: json['status'],
//       date: json['date'],
//       studentList: studentList,
//       infoTopicRegisterList: infoTopicRegisterList,
//     );
//   }
// }
