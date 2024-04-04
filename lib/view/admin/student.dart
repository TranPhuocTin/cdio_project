import 'package:cdio_project/model/student/student.dart';
import 'package:cdio_project/providers/student_provider.dart';
import 'package:cdio_project/view/admin/student_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageStudentScreen extends ConsumerStatefulWidget {
  const ManageStudentScreen({Key? key}) : super(key: key);

  @override
  _ManageStudentScreenState createState() => _ManageStudentScreenState();
}

class _ManageStudentScreenState extends ConsumerState<ManageStudentScreen> {
  int? studentIdSearch;
  bool emptySearch = false;

  @override
  void initState() {
    super.initState();
    ref.refresh(studentProvider);
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Student>> listStudents = ref.watch(studentProvider);

    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 158, 136, 69),
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
                studentIdSearch = int.tryParse(value);
                emptySearch = false;
              });
            }
          },
          onSubmitted: (value) {
            setState(() {
              studentIdSearch = int.tryParse(value);
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
              Color.fromARGB(255, 193, 122, 60),
              Color.fromARGB(255, 196, 160, 52)
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: listStudents.when(
            data: (students) {
              List<Student> filteredStudents = [];
              if (studentIdSearch != null && !emptySearch) {
                filteredStudents = students
                    .where((student) => student.studentId == studentIdSearch)
                    .toList();
              } else {
                filteredStudents = students;
              }
              return ListView.builder(
                itemCount: filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = filteredStudents[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: StudentInfo(
                      studentName: student.name,
                      address: student.address,
                      studentId: student.studentId,
                      studentAvatar: student.avatar,
                      student: student,
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
          // Handle adding a new student
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class StudentInfo extends StatelessWidget {
  StudentInfo({
    Key? key,
    required this.studentName,
    required this.address,
    required this.studentId,
    required this.studentAvatar,
    this.student,
  }) : super(key: key);

  final String studentName;
  final String address;
  final int studentId;
  final String studentAvatar;
  Student? student;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StudentDetailSliver(
            student: student!,
          ),
        ));
      },
      child: Card(
        elevation: 50,
        color: Theme.of(context).cardTheme.color,
        shadowColor: Theme.of(context).cardTheme.shadowColor,
        surfaceTintColor: Theme.of(context).cardTheme.surfaceTintColor,
        child: ListTile(
          title: Text(
            '$studentName - ${studentId.toString()}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(address),
          leading: CircleAvatar(
            backgroundImage: studentAvatar == 'Register.png'
                ? const NetworkImage(
                    'https://c0.klipartz.com/pngpicture/199/210/gratis-png-equipo-iconos-avatar-usuario-perfil-recomendador-sistema-avatar.png')
                : NetworkImage(studentAvatar),
          ),
          dense: true,
        ),
      ),
    );
  }
}
