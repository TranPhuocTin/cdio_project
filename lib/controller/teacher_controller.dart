import 'dart:convert';
import 'dart:io';

import 'package:cdio_project/controller/auth_controller.dart';
import 'package:cdio_project/model/teacher/page_teacher.dart';
import 'package:cdio_project/model/teacher/teacher.dart';
import 'package:cdio_project/model/teacher/teacher_register.dart';
// import 'package:cdio_project/model/teacher/teacher_update.dart';
import 'package:cdio_project/model/teacher/teacher_detail_model.dart';
import 'package:cdio_project/model/teacher/teacher_update.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class TeacherController {
  static const apiUrl = 'http://10.0.2.2:8080/api/teachers/list?find=&page=';

  static Future<List<Teacher>> fetchTeachers() async {
    int currentPage = 0;
    List<Teacher> teachers = [];

    try {
      while (true) {
        final response = await http.get(
          Uri.parse('$apiUrl$currentPage'),
          headers: {
            'Authorization': 'Bearer ${await AuthController.readToken()}',
            'Content-Type': 'application/json',
          },
        );
        if (response.statusCode == 200) {
          final decodedString = utf8.decode(response.bodyBytes);
          final data = jsonDecode(decodedString);
          List<dynamic> content = data['content'];
          for (var item in content) {
            teachers.add(Teacher.fromJson(item));
          }
          if (data['last'] == true) {
            break;
          } else {
            currentPage++;
          }
        }
      }
      return teachers;
    } catch (e) {
      throw Exception('Failed to load teachers');
    }

    // if (response.statusCode == 200) {
    //   final data = jsonDecode(response.body);
    //   List<dynamic> content = data['content'];
    //   for (var item in content) {
    //     teachers.add(Teacher.fromJson(item));
    //   }
    //   return teachers;
    // } else {
    //   throw Exception('Failed to load teachers');
    // }
  }

  static Future<PageTeacherAttribute> fetchPageAtribute() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${await AuthController.readToken()}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PageTeacherAttribute.fromJson(data);
    } else {
      throw Exception('Failed to load teachers');
    }
  }

  Future<TeacherDetailModel> fetchTeacherDetail(int teacherId) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/teachers/getTeacherById/$teacherId'),
      headers: {
        'Authorization': 'Bearer ${await AuthController.readToken()}',
      },
    );
    if (response.statusCode == 200) {
      final decodedString = utf8.decode(response.bodyBytes);
      final data = jsonDecode(decodedString);
      return TeacherDetailModel.fromJson(data);
    } else {
      throw Exception('Failed to load teacher info');
    }
  }

  // static Future<void> updateTeacher(TeacherUpdate teacher) async {
  //   final response = await http.post(
  //     Uri.parse('http://10.0.2.2:8080/api/teachers/updateTeacher'),
  //     body: json.encode(teacher.toJson()),
  //     headers: {
  //       'Authorization': 'Bearer ${await AuthController.readToken()}',
  //     },
  //   );
  //   print(response.statusCode);
  //   if(response.statusCode == 200){
  //     print('Update success');

  //   } else {
  //     throw Exception('Failed to update teacher');
  //   }
  // }

  Future<void> updateTeacher(TeacherUpdate teacher) async {
    const String apiUrl = 'http://10.0.2.2:8080/api/teachers/updateTeacher';

    String jsonTeacher = json.encode(teacher.toJson());
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await AuthController.readToken()}',
        },
        body: jsonTeacher,
      );
      print(response.body);
      // Kiểm tra mã trạng thái của phản hồi từ backend
      if (response.statusCode == 200) {
        print('Update success');
      } else {
        print('Failed to update teacher. Error code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> pickImage() async {
    XFile? avatar = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (avatar != null) {
      return avatar.path;
    }
    return 'Khong co anh duoc chon';
  }

  Future<String> upLoadImage(String avatarPath, int teacherId) async {
    try {
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDireImage =
          referenceRoot.child('teachers_avatar').child('$teacherId');
      UploadTask uploadTask = referenceDireImage.putFile(
          File(avatarPath), SettableMetadata(contentType: 'image/jpg'));
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      return 'Khong co anh duoc chon';
    }
  }

  Future<bool> deleteTeacher(int teacherId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://10.0.2.2:8080/api/teachers/$teacherId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await AuthController.readToken()}',
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to delete teacher');
    }
  }


  Future<void> createTeacher(TeacherRegister teacherRegister) async {
    try {
      final response = await http.post(
          Uri.parse('http://10.0.2.2:8080/api/teachers/createTeacher'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${await AuthController.readToken()}'
          },
          body: json.encode(teacherRegister.toJson()));
          print(response.statusCode);
      if (response.statusCode == 200) {
        print('Create success');
      }
    } catch (e) {
      throw Exception('Failed to create teacher');
    }
  }
}
