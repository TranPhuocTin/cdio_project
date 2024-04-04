import 'package:cdio_project/controller/auth_controller.dart';
import 'package:cdio_project/view/admin/change_password.dart';
import 'package:cdio_project/view/login.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ManageTeacherScreen();
}

class _ManageTeacherScreen extends State<ProfileScreen> {
  void _changePassword() async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ChangePassword()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              AuthController.saveToken(null);
              AuthController.setloginStatus(false);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Login()));
            },
            title: const Text('Đăng xuất'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Divider(color: Colors.grey),
          ),
          ListTile(
            onTap: () {
              _changePassword();
            },
            title: const Text('Đổi mật khẩu'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Divider(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
