import 'package:cdio_project/controller/student_controller.dart';
import 'package:cdio_project/controller/teacher_controller.dart';
import 'package:cdio_project/model/teacher/teacher.dart';
import 'package:cdio_project/model/teacher/teacher.dart';
import 'package:cdio_project/model/teacher/teacher_detail_model.dart';
import 'package:cdio_project/model/teacher/teacher_update.dart';
import 'package:cdio_project/providers/student_provider.dart';
import 'package:cdio_project/providers/teacher_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TeacherDetailV2 extends ConsumerStatefulWidget {
  const TeacherDetailV2({super.key, required this.teacherId});

  final int teacherId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => StudentEidtInfoState();
}

class StudentEidtInfoState extends ConsumerState<TeacherDetailV2> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController dateOfBirthController = TextEditingController();
  late Future<TeacherDetailModel> teacher;

  String name = '';
  String dateOfBirth = '';
  String address = '';
  String phone = '';
  String mail = '';
  bool gender = true;
  bool isPickedDate = false;
  int facultyId = 1;
  int degreeId = 1;
  String avatar = '';
  var _teacherAvatarPatch = '';
  var _studentFirebaseAvatar = '';
  bool _selectedImage = false;
  bool _loadingAvatar = false;

  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }

  // void _pickImage() async {
  //   await StudentController().pickImage().then((value) {
  //     _teacherAvatarPatch = value;
  //     _selectedImage = true;
  //   });
  // }

  // void _updateAvatar() async {
  //   formKey.currentState!.save();
  //   var networkImage = await TeacherController()
  //       .upLoadImage(_teacherAvatarPatch, widget.teacherId);
  //   await TeacherController().updateTeacher(
  //     TeacherUpdate(
  //         teacherId: widget.teacherId,
  //         name: name,
  //         dateOfBirth: dateOfBirth,
  //         address: address,
  //         phone: phone,
  //         email: mail,
  //         facultyId: facultyId,
  //         degreeId: degreeId,
  //         avatar: '$networkImage.png',
  //         gender: gender,
  //         accountId: null),
  //   );
  //   setState(() {
  //     _studentFirebaseAvatar = '$networkImage.png';
  //     _loadingAvatar = false;
  //   });
  //   // ignore: unused_result
  //   ref.refresh(teachersProvider);
  // }

  void _pickImageAndUpload() async {
    setState(() {
      _loadingAvatar = true; // Hiển thị spinkit khi bắt đầu chọn ảnh
    });

    // Chọn ảnh
    var value = await StudentController().pickImage();

    setState(() {
      _teacherAvatarPatch = value;
      _selectedImage = true;
    });

    // Sau khi chọn ảnh, cập nhật avatar
    _updateAvatar();
  }

  void _updateAvatar() async {
    // Thực hiện cập nhật thông tin sinh viên với avatar mới
    var networkImage = await TeacherController()
        .upLoadImage(_teacherAvatarPatch, widget.teacherId);

    await TeacherController().updateTeacher(
      TeacherUpdate(
          teacherId: widget.teacherId,
          name: name,
          dateOfBirth: dateOfBirth,
          address: address,
          phone: phone,
          email: mail,
          facultyId: facultyId,
          degreeId: degreeId,
          avatar: '$networkImage.png',
          gender: gender,
          accountId: null),
    );

    setState(() {
      _studentFirebaseAvatar = '$networkImage.png';
      _loadingAvatar = false; // Ẩn spinkit sau khi cập nhật thành công
    });

    // Làm mới dữ liệu
    ref.refresh(teachersProvider);
  }

  void _updateTeacher() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận'),
        content: const Text('Bạn có chắc muốn cập nhật sinh viên này không'),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              formKey.currentState!.save();
              await teacher.then((teacherDetail) {
                facultyId = teacherDetail.facultyId;
                avatar = teacherDetail.avatar;
                print(avatar);
                degreeId = teacherDetail.degreeId;
              });
              await TeacherController().updateTeacher(
                TeacherUpdate(
                    teacherId: widget.teacherId,
                    name: name,
                    dateOfBirth: dateOfBirth,
                    address: address,
                    phone: phone,
                    email: mail,
                    facultyId: facultyId,
                    degreeId: degreeId,
                    avatar: avatar,
                    gender: gender,
                    accountId: null),
              );
              if (mounted) {
                // ignore: unused_result
                ref.refresh(teachersProvider);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            },
            icon: Image.asset(
              'assets/icons/completed.png',
              width: 30,
              height: 30,
            ),
            label: const Text('Đồng ý'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset(
              'assets/icons/close.png',
              width: 30,
              height: 30,
            ),
            label: const Text('Hủy'),
          ),
        ],
      ),
    );
  }

  void _deleteTeacher(int teacherId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận'),
        content: const Text('Bạn có chắc muốn xóa sinh viên này không'),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              formKey.currentState!.save();
              await TeacherController().deleteTeacher(teacherId);
              if (mounted) {
                // ignore: unused_result
                ref.refresh(teachersProvider);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            },
            icon: Image.asset(
              'assets/icons/completed.png',
              width: 30,
              height: 30,
            ),
            label: const Text('Đồng ý'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Image.asset(
              'assets/icons/close.png',
              width: 30,
              height: 30,
            ),
            label: const Text('Hủy'),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> pickDateOfBirth() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        isPickedDate = true;
        dateOfBirthController.text = selectedDate.toString().substring(0, 10);
      });
    }

    return null;
  }

  @override
  void initState() {
    teacher = TeacherController().fetchTeacherDetail(widget.teacherId);
    teacher.then((teacherDetail) {
      // Access the date of birth from the teacher detail
      final dateOfBirth = teacherDetail.dateOfBirth;
      avatar = teacherDetail.avatar;
      // Set the date of birth to the dateOfBirthController
      dateOfBirthController.text = dateOfBirth.toString().substring(0, 10);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final spinkit = SpinKitWave(
      color: Colors.white,
      size: 30,
    );

    return Scaffold(
        body: FutureBuilder(
      future: teacher,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                // title: const Text(
                //   'Chỉnh sửa giảng viên',
                //   style: TextStyle(
                //     fontSize: 23,
                //   ),
                // ),
                expandedHeight: 250,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff4c5c92),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 23,
                        ),
                        Center(
                          //Login xảy ra vấn đề khi update 2 lần thì hiện ảnh của lần đầu tiên
                          child: InkWell(
                            onTap: () {
                              // setState(() {
                              //   _loadingAvatar = true;
                              // });
                              // _pickImage();
                              // if (_selectedImage) {
                              //   _updateAvatar();
                              // } else {
                              //   _teacherAvatarPatch = avatar;
                              //   setState(() {
                              //     _loadingAvatar = false;
                              //     _studentFirebaseAvatar = avatar;
                              //   });
                              // }
                              // setState(() {
                              //   _loadingAvatar = false;
                              // });
                              _pickImageAndUpload();
                            },
                            child:
                                Stack(alignment: Alignment.center, children: [
                              CircleAvatar(
                                radius: 80,
                                backgroundImage: _selectedImage
                                    ? NetworkImage(_studentFirebaseAvatar)
                                    : NetworkImage(avatar),
                              ),
                              _loadingAvatar ? spinkit : Text(''),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          snapshot.data!.name.toString(),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                centerTitle: true,
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SliverToBoxAdapter(
                child: Form(
                  key: formKey,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 600,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/icons/ID.png',
                                          width: 30,
                                          height: 30,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Text(
                                            snapshot.data!.teacherId.toString(),
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/icons/name.png',
                                          width: 30,
                                          height: 30,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: SizedBox(
                                            height: 30,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: TextFormField(
                                              initialValue: snapshot.data!.name,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              textAlign: TextAlign.right,
                                              onSaved: (newValue) {
                                                if (newValue != null) {
                                                  name = newValue;
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          pickDateOfBirth();
                                        },
                                        icon: Image.asset(
                                          'assets/icons/birthday.png',
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: SizedBox(
                                          height: 70,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: TextFormField(
                                            controller: dateOfBirthController,
                                            // initialValue: snapshot.data!.dateOfBirth.toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            textAlign: TextAlign.right,
                                            onSaved: (newValue) {
                                              if (newValue != null) {
                                                dateOfBirth = newValue;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'assets/icons/address.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: SizedBox(
                                          height: 70,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: TextFormField(
                                            initialValue:
                                                snapshot.data!.address,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            textAlign: TextAlign.right,
                                            onSaved: (newValue) {
                                              if (newValue != null) {
                                                address = newValue;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'assets/icons/phone.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: SizedBox(
                                          height: 70,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: TextFormField(
                                            initialValue: snapshot.data!.phone,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            textAlign: TextAlign.right,
                                            onSaved: (newValue) {
                                              if (newValue != null) {
                                                phone = newValue;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'assets/icons/gmail.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: SizedBox(
                                          height: 70,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: TextFormField(
                                            initialValue: snapshot.data!.email,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            textAlign: TextAlign.right,
                                            onSaved: (newValue) {
                                              if (newValue != null) {
                                                mail = newValue;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'assets/icons/gender.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: SizedBox(
                                          height: 70,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: TextFormField(
                                            initialValue: snapshot.data!.gender
                                                ? 'Nam'
                                                : 'Nữ',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            textAlign: TextAlign.right,
                                            onSaved: (newValue) {
                                              if (newValue == 'Nam') {
                                                gender = true;
                                              } else {
                                                gender = false;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 25,
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(9)),
                          onPressed: _updateTeacher,
                          icon: Image.asset('assets/icons/edit.png'),
                          label: const Text('Cập nhật')),
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(9)),
                          onPressed: () {
                            _deleteTeacher(snapshot.data!.teacherId);
                          },
                          icon: Image.asset('assets/icons/delete.png'),
                          label: const Text('Xóa')),
                    )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 70),
              )
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (!snapshot.hasData) {
          return const Text('Khong co du lieu');
        } else {
          return const Text('Loi');
        }
      },
    ));
  }
}
