import 'package:cdio_project/controller/student_controller.dart';
import 'package:cdio_project/model/student/student.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final studentProvider = FutureProvider<List<Student>>((ref) async => await StudentController().fetchStudents()); 
