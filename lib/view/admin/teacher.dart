import 'package:cdio_project/model/teacher/teacher.dart';
import 'package:cdio_project/providers/teacher_provider.dart';
import 'package:cdio_project/view/admin/teacher_detail.dart';
import 'package:cdio_project/view/admin/teacher_create.dart';
import 'package:cdio_project/view/admin/teacher_detail_v2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageTeacherScreen extends ConsumerStatefulWidget {
  const ManageTeacherScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ManageTeacherScreenState();
}

class _ManageTeacherScreenState extends ConsumerState<ManageTeacherScreen> {
  int? teacherIdSearch;
  bool emptySearch = false;

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Teacher>> listTeachers = ref.watch(teachersProvider);

    return Scaffold(
      // backgroundColor: Color(0xff4c5c92),
      appBar: AppBar(
        title: CupertinoSearchTextField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if (value.isEmpty || value == '') {
              setState(() {
                emptySearch = true;
              });
            } else {
              setState(() {
                teacherIdSearch = int.tryParse(value);
                emptySearch = false;
              });
            }
          },
          onSubmitted: (value) {
            setState(() {
              teacherIdSearch = int.tryParse(value);
            });
          },
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 61, 75, 119),
              Color.fromARGB(255, 85, 101, 153),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: listTeachers.when(
            data: (teachers) {
              List<Teacher> filteredTeachers = [];
              if (teacherIdSearch != null && !emptySearch) {
                filteredTeachers = teachers
                    .where((teacher) => teacher.teacherId == teacherIdSearch)
                    .toList();
              } else {
                filteredTeachers = teachers;
              }
              return ListView.builder(
                itemCount: filteredTeachers.length,
                itemBuilder: (context, index) {
                  final teacher = filteredTeachers[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TeacherInfo(
                      teacherName: teacher.teacherName,
                      facultyName: teacher.facultyName,
                      teacherId: teacher.teacherId,
                      teacherAvatar: teacher.avatar,
                    ),
                  );
                },
              );
            },
            error: (error, stackTrace) {
              return Center(
                child: Text(
                  'Error: $error',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            elevation: 0.5,
            useSafeArea: true,
            builder: (context) => const TeacherCreate(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ignore: must_be_immutable
class TeacherInfo extends StatelessWidget {
  TeacherInfo({
    super.key,
    required this.teacherName,
    required this.facultyName,
    required this.teacherId,
    required this.teacherAvatar,
    this.teacher,
  });

  final String teacherName;
  final String facultyName;
  final int teacherId;
  final String teacherAvatar;
  Teacher? teacher;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return TeacherDetailV2(
                teacherId: teacherId,
              );
              // return TeacherDetailV2(teacher: teacher);
            },
          ),
        );
      },
      child: Card(
        elevation: 50,
        color: Theme.of(context).cardTheme.color,
        shadowColor: Theme.of(context).cardTheme.shadowColor,
        surfaceTintColor: Theme.of(context).cardTheme.surfaceTintColor,
        child: ListTile(
          title: Text(
            '$teacherName - ${teacherId.toString()}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(facultyName),
          leading: CircleAvatar(backgroundImage: NetworkImage(teacherAvatar)),
          dense: true,
        ),
      ),
    );
  }
}
