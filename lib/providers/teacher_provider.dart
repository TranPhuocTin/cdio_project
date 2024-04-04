import 'package:cdio_project/controller/teacher_controller.dart';
import 'package:cdio_project/model/teacher/teacher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final teachersProvider = FutureProvider<List<Teacher>>((ref) async => await TeacherController.fetchTeachers()); 
