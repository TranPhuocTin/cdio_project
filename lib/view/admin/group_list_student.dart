import 'package:cdio_project/model/student/student.dart';
import 'package:cdio_project/view/admin/student.dart';
import 'package:flutter/material.dart';

class GroupListStudent extends StatefulWidget {
  const GroupListStudent({super.key, required this.student});

  final Student student;

  @override
  State<GroupListStudent> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<GroupListStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student.name),
      ),
      body: ListView.builder(
        itemCount: widget.student.groupAccount!.studentList!.length,
        itemBuilder: (context, index) {
          return StudentInfo(
              studentName:
                  widget.student.groupAccount!.studentList![index].name,
              address: widget.student.groupAccount!.studentList![index].address,
              studentId:
                  widget.student.groupAccount!.studentList![index].studentId,
              studentAvatar:
                  widget.student.groupAccount!.studentList![index].avatar);
        },
      ),
    );
  }
}
