import 'dart:convert';
import 'dart:io';
import 'package:cdio_project/controller/auth_controller.dart';
import 'package:cdio_project/model/student/student_update.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:cdio_project/model/student/student.dart';
import 'package:image_picker/image_picker.dart';

class StudentController {
  static const String apiUrl = 'http://10.0.2.2:8080/api/';

  Future<List<Student>> fetchStudents() async {
    final response = await http.get(
      Uri.parse('${apiUrl}student-list?page=&&find='),
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer ${await AuthController.readToken()}',
      },
    );
    if (response.statusCode == 200) {
      final decodedString = utf8.decode(response.bodyBytes);
      final data = jsonDecode(decodedString);
      final List<dynamic> content = data['content'];
      List<Student> students =
          content.map((item) => Student.fromJson(item)).toList();
      print(students[0].groupAccount!.date);
      return students;
    } else {
      throw Exception('Failed to load students');
    }
  }

  Future<String> pickImage() async {
    XFile? avatar = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (avatar != null) {
      return avatar.path;
    }
    return 'Khong co anh duoc chon';
  }

  Future<String> upLoadImage(String avatarPath, int studentId) async {
    try {
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDireImage =
          referenceRoot.child('students_avatar').child('$studentId');
      UploadTask uploadTask = referenceDireImage.putFile(
          File(avatarPath), SettableMetadata(contentType: 'image/jpg'));
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e.toString());
      return 'Khong co anh duoc chon';
    }
  }

  Future<void> updateStudent(StudentUpdate student) async {
    const String apiUrl = 'http://10.0.2.2:8080/api/edit-student';

    String jsonStudent = json.encode(student.toJson());
    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await AuthController.readToken()}',
        },
        body: jsonStudent,
      );
      print(response.body);
      // Kiểm tra mã trạng thái của phản hồi từ backend
      if (response.statusCode == 200) {
        print('Update success');
      } else {
        print('Failed to update student. Error code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
