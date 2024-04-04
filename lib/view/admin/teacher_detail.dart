
import 'package:cdio_project/model/teacher/teacher_detail_model.dart';
import 'package:cdio_project/model/teacher/teacher_update.dart';
import 'package:flutter/material.dart';
import 'package:cdio_project/controller/teacher_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cdio_project/providers/teacher_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TeacherDetail extends ConsumerStatefulWidget {
  const TeacherDetail({super.key, required this.teacherId});

  final int teacherId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TeacherDetailState();
}

class _TeacherDetailState extends ConsumerState<TeacherDetail> {
  late Future<TeacherDetailModel> teacherDetail;
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _dateOfBirth = '';
  String _address = '';
  String _phone = '';
  String _email = '';
  int _facultyId = 1;
  int _degreeId = 1;
  String _avatarLink = '';
  bool _gender = true;
  bool isUpdate = false;
  String avatarUrl = '';
  String avatarPatch = '';
  bool isPickedImage = false;
  // double _opacity = 0.0;
  // String _accountId = '';

  void _updateTeacher(BuildContext context) async {
    _formKey.currentState!.save();
    await TeacherController()
        .upLoadImage(avatarPatch, widget.teacherId)
        .then((value) => _avatarLink = value);
    final teacher = TeacherUpdate(
      teacherId: widget.teacherId,
      name: _name,
      dateOfBirth: _dateOfBirth,
      address: _address,
      phone: _phone,
      email: _email,
      facultyId: _facultyId,
      degreeId: _degreeId,
      // avatar: avatarUrl,
      avatar: '$_avatarLink.jpg',
      gender: _gender,
      accountId: null,
    );
    setState(() {
      isUpdate = true;
    });
    try {
      await TeacherController().updateTeacher(teacher);
      // ignore: unused_result
      ref.refresh(teachersProvider);
      // await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      throw Exception('Failed to update teacher');
    }
    // setState(() {
    //   isUpdate = false;
    // });
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  void _deleteTeacher(int teacherId) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc muốn xóa giáo viên chứ?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              await TeacherController().deleteTeacher(teacherId);
              if(mounted){
                print('1');
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                ref.refresh(teachersProvider);
              }
            },
            child: const Text('Xóa'),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    teacherDetail = TeacherController().fetchTeacherDetail(widget.teacherId);

    // Future.delayed(const Duration(milliseconds: 500), () {
    //   setState(() {
    //     _opacity = 1.0;
    //   });
    // });https://p7.hiclipart.com/preview/442/477/305/computer-icons-user-profile-avatar-profile.jpg
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar(
        title: Text(
          'Chi tiết giảng viên',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: FutureBuilder(
        future: teacherDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 80,
                              child: SizedBox(
                                width: 160,
                                height: 160,
                                child: InkWell(
                                  onTap: () {
                                    TeacherController()
                                        .pickImage()
                                        .then((value) {
                                      avatarPatch = value;
                                      setState(() {
                                        isPickedImage = true;
                                      });
                                    });
                                  },
                                  child: ClipOval(
                                    child: snapshot.data!.avatar == 'Register.png'
                                        ? Image.network('https://c0.klipartz.com/pngpicture/199/210/gratis-png-equipo-iconos-avatar-usuario-perfil-recomendador-sistema-avatar.png', fit: BoxFit.cover,)
                                        : CachedNetworkImage(
                                            imageUrl: snapshot.data!.avatar,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                //Cho phep nguoi dung nhap du lieu
                                // enabled: true,
                                initialValue: snapshot.data!.name,
                                decoration: const InputDecoration(
                                  labelText: 'Họ và tên',
                                ),
                                //Có sử dụng null check operator nên nếu có lỗi xảy ra thì đây là nơi cần kiểm tra
                                onSaved: (newValue) {
                                  _name = newValue!;
                                  _avatarLink = snapshot.data!.avatar;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text('ID: ${snapshot.data!.teacherId}'),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                initialValue: snapshot.data!.email,
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
                                style: Theme.of(context)
                                    .dropdownMenuTheme
                                    .textStyle,
                                value: snapshot.data!.facultyId,
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
                                onSaved: (newValue) =>
                                    _facultyId = newValue as int,
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
                                initialValue: snapshot.data!.phone,
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
                                style: Theme.of(context)
                                    .dropdownMenuTheme
                                    .textStyle,
                                value: snapshot.data!.gender,
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
                                onSaved: (newValue) =>
                                    _gender = newValue as bool,
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
                                  initialValue: snapshot.data!.dateOfBirth
                                      .toString()
                                      .substring(0, 10),
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
                                style: Theme.of(context)
                                    .dropdownMenuTheme
                                    .textStyle,
                                value: snapshot.data!.degreeId,
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
                                onSaved: (newValue) =>
                                    _degreeId = newValue as int,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                initialValue: snapshot.data!.address,
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
                                _updateTeacher(context);
                              },
                              icon: isUpdate
                                  ? const Padding(
                                      padding: EdgeInsets.all(5),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        strokeAlign: 1,
                                      ))
                                  : const Icon(Icons.update),
                              label: isUpdate
                                  ? const Text('')
                                  : const Text('Update'),
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _deleteTeacher(widget.teacherId);
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                              label: const Text('Delete'),
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
