import 'package:cdio_project/controller/auth_controller.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  bool? isPasswordValid;

  @override
  Widget build(BuildContext context) {
    String oldPassword = '';
    String newPassword = '';
    String confirmPassword = '1';
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    void changePassword() async {
      formKey.currentState!.save();
      print('Old $oldPassword');
      print('New $newPassword');
      print('Confirm $confirmPassword');

      var isSuccess = await AuthController()
          .changePassword(oldPassword, newPassword, confirmPassword);
      if (isSuccess == false) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Thay đổi mật khẩu thất bại, vui lòng kiểm tra lại!',
                style: TextStyle(fontSize: 12),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            );
          },
        );
      }
      else{
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            AuthController.saveToken(null);
            AuthController.setloginStatus(false);
            return AlertDialog(
              title: const Text(
                'Thay đổi mật khẩu thành công',
                style: TextStyle(fontSize: 12),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
              
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi mật khẩu'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mật khẩu cũ',
                ),
                onSaved: (value) {
                  oldPassword = value!;
                },
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Mật khẩu phải có ít nhất 6 ký tự';
                  }
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mật khẩu mới',
                ),
                onSaved: (value) {
                  newPassword = value!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Xác nhận mật khẩu mới'),
                onSaved: (value) {
                  confirmPassword = value!;
                },
              ),
              const SizedBox(height: 50),
              Center(
                child: TextButton(
                  onPressed: () {
                    changePassword();
                  },
                  child: const Text('Đổi mật khẩu'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
