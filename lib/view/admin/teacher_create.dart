import 'package:cdio_project/controller/teacher_controller.dart';
import 'package:flutter/material.dart';
import 'package:cdio_project/model/teacher/teacher_register.dart';

class TeacherCreate extends StatefulWidget {
  const TeacherCreate({super.key});

  @override
  State<TeacherCreate> createState() => _TeacherCreateState();
}

class _TeacherCreateState extends State<TeacherCreate> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _dateOfBirth = '';
  String _address = '';
  String _phone = '';
  String _email = '';
  int _facultyId = 1;
  int _degreeId = 1;
  bool _gender = true;
  bool isUpdate = false;
  String avatarUrl = '';
  String avatarPatch = '';
  bool isPickedImage = false;

  void _createTeacher() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await TeacherController().createTeacher(
        TeacherRegister(
            name: _name,
            dateOfBirth: _dateOfBirth,
            address: _address,
            phone: _phone,
            email: _email,
            facultyId: _facultyId,
            degreeId: _degreeId,
            avatar: 'Register.png',
            gender: _gender),
      );
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm mới giảng viên'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Họ và tên',
                        ),
                        //Có sử dụng null check operator nên nếu có lỗi xảy ra thì đây là nơi cần kiểm tra
                        onSaved: (newValue) {
                          _name = newValue!;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        //Có sử dụng null check operator nên nếu có lỗi xảy ra thì đây là nơi cần kiểm tra
                        onSaved: (newValue) => _email = newValue!,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField(
                        alignment: Alignment.center,
                        // dropdownColor: Theme.of(context).colorScheme.onSecondaryContainer,
                        style: Theme.of(context).dropdownMenuTheme.textStyle,
                        padding: const EdgeInsets.only(top: 16),
                        items: const [
                          DropdownMenuItem(
                            value: 1,
                            child: Text(
                              'CNTT',
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text('CNPM'),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Text('GAME'),
                          ),
                        ],
                        onChanged: (value) {
                          _facultyId = value as int;
                        },
                        onSaved: (newValue) => _facultyId = newValue as int,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          label: Text('Số điện thoại'),
                        ),
                        //Có sử dụng null check operator nên nếu có lỗi xảy ra thì đây là nơi cần kiểm tra
                        onSaved: (newValue) => _phone = newValue!,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField(
                        alignment: Alignment.center,
                        // dropdownColor: Theme.of(context).colorScheme.onSecondaryContainer,
                        style: Theme.of(context).dropdownMenuTheme.textStyle,
                        padding: const EdgeInsets.only(top: 16),
                        items: const [
                          DropdownMenuItem(
                            value: true,
                            child: Text(
                              'Nam',
                            ),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Nữ'),
                          ),
                        ],
                        onChanged: (value) {
                          _gender = value as bool;
                        },
                        onSaved: (newValue) => _gender = newValue as bool,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                          keyboardType: TextInputType.datetime,
                          decoration: const InputDecoration(
                            label: Text('Ngày sinh'),
                          ),
                          onSaved: (newValue) {
                            _dateOfBirth = newValue!;
                          }),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField(
                        alignment: Alignment.center,
                        // dropdownColor: Theme.of(context).colorScheme.onSecondaryContainer,
                        style: Theme.of(context).dropdownMenuTheme.textStyle,
                        padding: const EdgeInsets.only(top: 16),
                        items: const [
                          DropdownMenuItem(
                            value: 1,
                            child: Text('Cử nhân'),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text('Tiến sĩ'),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Text('Thạc sĩ'),
                          ),
                        ],
                        onChanged: (value) {
                          _degreeId = value as int;
                        },
                        onSaved: (newValue) => _degreeId = newValue as int,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Địa chỉ',
                        ),
                        //Null check operator here
                        onSaved: (newValue) => _address = newValue!,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        _createTeacher();
                      },
                      icon: isUpdate
                          ? const Padding(
                              padding: EdgeInsets.all(5),
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                strokeAlign: 1,
                              ),
                            )
                          : const Icon(Icons.add),
                      label: isUpdate ? const Text('') : const Text('Thêm'),
                      style: Theme.of(context).elevatedButtonTheme.style,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
