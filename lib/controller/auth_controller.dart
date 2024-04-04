import 'dart:convert';
import 'package:cdio_project/model/user/roles.dart';
import 'package:cdio_project/model/user/user.dart';
import 'package:cdio_project/model/user/change_password.dart';
import 'package:http/http.dart' as http;
import "package:shared_preferences/shared_preferences.dart";

class AuthController {
  static const String apiUrl = 'http://10.0.2.2:8080/api/auth/sign-in';
  static final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();

  static Future<void> login(
      String username, String password, bool isRemember) async {
    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: jsonEncode({'userName': username, 'password': password}),
          headers: {'Content-Type': 'application/json'});
      print(response.statusCode);
      if (response.statusCode == 200) {
        final decodedString = utf8.decode(response.bodyBytes);
        final userInfo = User.fromJson(jsonDecode(decodedString));
        // Lưu token vào SharedPreferences
        await saveToken(userInfo.userId);
        userRoles = userInfo.roles.toList();
        // Luu trang thai dang nhap
        if (isRemember) {
          setloginStatus(true);
        }
      } else {
        // print("Sai ten nguoi dung hoac mat khau!");
      }
    } catch (e) {
      // print(e);
    }
  }

  // Phương thức để lưu token vào SharedPreferences
  static Future<void> saveToken(String? token) async {
    if (token != null) {
      final prefs = await _preferences;
      prefs.setString('token', token);
    }
  }

  // Phương thức để đọc token từ SharedPreferences
  static Future<String?> readToken() async {
    return await _preferences.then((prefs) => prefs.getString('token'));
  }

  static Future<void> setloginStatus(bool status) async {
    final prefs = await _preferences;
    prefs.setBool('loginStatus', status);
  }

  static Future<bool?> readLoginStatus() async {
    return _preferences.then((prefs) => prefs.getBool('loginStatus'));
  }

  Future<bool> changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    try {
      var body = json.encode(ChangePassword(
              oldPassword: oldPassword,
              newPassword: newPassword,
              confirmPassword: confirmPassword)
          .toJson());
      print('Test function changePassword');
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/auth/change-password'),
        headers: {
          'Content-Type': 'Application/json',
          'Authorization': 'Bearer ${await AuthController.readToken()}'
        },
        body: body
      );
      print('Test function changePassword2');

      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
