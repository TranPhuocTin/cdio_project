import 'package:cdio_project/controller/student_controller.dart';
import 'package:cdio_project/model/student/student.dart';
import 'package:cdio_project/model/student/student_update.dart';
import 'package:cdio_project/providers/student_provider.dart';
import 'package:cdio_project/view/admin/group_list_student.dart';
import 'package:cdio_project/view/admin/student_edit_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StudentDetailSliver extends ConsumerStatefulWidget {
  const StudentDetailSliver({super.key, required this.student});

  final Student student;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      StudentDetailSliverState();
}

class StudentDetailSliverState extends ConsumerState<StudentDetailSliver> {
  var _studentAvatarPatch = '';
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

  void _pickImageAndUpload() async {
  setState(() {
    _loadingAvatar = true; // Hiển thị spinkit khi đang tải ảnh
  });

  // Chọn ảnh
  var value = await StudentController().pickImage();

  setState(() {
    _studentAvatarPatch = value;
    _selectedImage = true;
  });

  // Sau khi chọn ảnh, cập nhật avatar
  _updateAvatar();
}

void _updateAvatar() async {
  print('1');
  var networkImage = await StudentController()
      .upLoadImage(_studentAvatarPatch, widget.student.studentId);
  print('2');

  // Cập nhật thông tin sinh viên với avatar mới
  await StudentController().updateStudent(StudentUpdate(
      studentId: widget.student.studentId,
      name: widget.student.name,
      dateOfBirth: widget.student.dateOfBirth,
      address: widget.student.address,
      phone: widget.student.phone,
      email: widget.student.email,
      avatar: '$networkImage.png',
      gender: widget.student.gender,
      grade: 1));
  setState(() {
    _studentFirebaseAvatar = '$networkImage.png';
    _loadingAvatar = false; // Ẩn spinkit sau khi cập nhật thành công
  });
  ref.refresh(studentProvider);
}

  // void _pickImage() async {
  //   await StudentController().pickImage().then((value) {
  //     _studentAvatarPatch = value;
  //     _selectedImage = true;
  //   });
  // }

  // void _updateAvatar() async {
  //   print('1');
  //   var networkImage = await StudentController()
  //       .upLoadImage(_studentAvatarPatch, widget.student.studentId);
  //   print('2');

  //   await StudentController().updateStudent(StudentUpdate(
  //       studentId: widget.student.studentId,
  //       name: widget.student.name,
  //       dateOfBirth: widget.student.dateOfBirth,
  //       address: widget.student.address,
  //       phone: widget.student.phone,
  //       email: widget.student.email,
  //       avatar: '$networkImage.png',
  //       gender: widget.student.gender,
  //       grade: 1));
  //   setState(() {
  //     _studentFirebaseAvatar = '$networkImage.png';
  //     _loadingAvatar = false;
  //   });
  //   ref.refresh(studentProvider);
  // }

  @override
  Widget build(BuildContext context) {
    final spinkit = SpinKitWave(
      color: Colors.white,
      size: 30,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentEditInfo(
                        student: widget.student,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
              ),
            ],
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFF2994A), Color(0xFFF2C94C)],
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          // setState(() {
                          //   _loadingAvatar = true;
                          // });
                          // _pickImage();
                          // if (_selectedImage) {
                          //   _updateAvatar();
                          // } else {
                          //   _studentAvatarPatch = widget.student.avatar;
                          //   setState(() {
                          //     _loadingAvatar = false;
                          //     _studentFirebaseAvatar = widget.student.avatar;
                          //   });
                          // }
                          _pickImageAndUpload();
                        },
                        child: Stack(alignment: Alignment.center, children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundImage: _selectedImage
                                ? NetworkImage(_studentFirebaseAvatar)
                                : NetworkImage(widget.student.avatar),
                          ),
                          _loadingAvatar ? spinkit : Text(''),
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.student.name,
                      style: const TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: Hero(
              tag: 'student',
              flightShuttleBuilder: _flightShuttleBuilder,
              child: Stack(
                children: [
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 330,
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/icons/ID.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      widget.student.studentId.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
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
                                    'assets/icons/name.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      widget.student.name,
                                      style: const TextStyle(
                                        fontSize: 16,
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
                                    'assets/icons/birthday.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      widget.student.dateOfBirth,
                                      style: const TextStyle(
                                        fontSize: 16,
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
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      widget.student.address,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
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
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      widget.student.phone,
                                      style: const TextStyle(
                                        fontSize: 16,
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
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      widget.student.email,
                                      style: const TextStyle(
                                        fontSize: 16,
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
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      widget.student.gender ? 'Nam' : 'Nữ',
                                      style: const TextStyle(
                                        fontSize: 16,
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
                  const Positioned(
                      left: 20,
                      top: -3,
                      child: Text(
                        'Thông tin sinh viên',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      height: 250,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/icons/ID.png',
                                  width: 30,
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    widget.student.groupAccount != null
                                        ? widget.student.groupAccount!
                                            .groupAccountId
                                            .toString()
                                        : 'Chưa có nhóm',
                                    style: const TextStyle(
                                      fontSize: 16,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/icons/name.png',
                                  width: 30,
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    widget.student.groupAccount != null
                                        ? widget.student.groupAccount!.name!
                                        : 'Chưa có nhóm',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Số thành viên: ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      widget.student.groupAccount != null
                                          ? widget.student.groupAccount!
                                              .studentList!.length
                                              .toString()
                                          : '0',
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Ngày tạo: ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    widget.student.groupAccount != null
                                        ? widget.student.groupAccount!.date!
                                        : 'Chưa có nhóm',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                if (widget.student.groupAccount != null) {
                                  if (widget
                                          .student.groupAccount!.studentList !=
                                      null) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GroupListStudent(
                                                  student: widget.student,
                                                )));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Sinh viên chưa có nhóm'),
                                      duration: Duration(seconds: 2),
                                      elevation: 0.5,
                                    ));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Sinh viên chưa có nhóm')));
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width - 65,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF2C94C),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Danh sách nhóm'),
                                      Icon(Icons.arrow_forward_ios_rounded),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 20,
                  top: -3,
                  child: Text(
                    'Thông tin nhóm',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      height: 200,
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
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'ID',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                      widget.student.groupAccount != null
                                          ? (widget.student.groupAccount!
                                                      .infoTopicRegisterList !=
                                                  null
                                              ? widget
                                                  .student
                                                  .groupAccount!
                                                  .infoTopicRegisterList![0]
                                                  .infoTopicRegisterId
                                                  .toString()
                                              : 'Chưa có đề tài')
                                          : 'Chưa có nhóm',
                                      style: const TextStyle(fontSize: 16),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Tên',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    widget.student.groupAccount != null
                                        ? (widget.student.groupAccount!
                                                    .infoTopicRegisterList !=
                                                null
                                            ? widget
                                                .student
                                                .groupAccount!
                                                .infoTopicRegisterList![0]
                                                .topic
                                                .name
                                                .toString()
                                            : 'Chưa có đề tài')
                                        : 'Chưa có nhóm',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Giới thiệu',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    widget.student.groupAccount != null
                                        ? (widget.student.groupAccount!
                                                    .infoTopicRegisterList !=
                                                null
                                            ? widget
                                                .student
                                                .groupAccount!
                                                .infoTopicRegisterList![0]
                                                .topic
                                                .introduce
                                                .toString()
                                            : 'Chưa có đề tài')
                                        : 'Chưa có nhóm',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Trạng thái',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: widget.student.groupAccount != null
                                      ? (widget.student.groupAccount!
                                                  .infoTopicRegisterList !=
                                              null
                                          ? (widget
                                                  .student
                                                  .groupAccount!
                                                  .infoTopicRegisterList![0]
                                                  .statusComplete
                                              ? Image.asset(
                                                  'assets/icons/completed.png',
                                                  width: 25,
                                                  height: 25,
                                                )
                                              : Image.asset(
                                                  'assets/icons/close.png',
                                                  width: 25,
                                                  height: 25,
                                                ))
                                          : const Text('Chưa có đề tài'))
                                      : const Text(
                                          'Chưa có nhóm',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Giáo viên',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: widget.student.groupAccount != null
                                      ? (widget.student.groupAccount!
                                                  .infoTopicRegisterList !=
                                              null
                                          ? (widget
                                                      .student
                                                      .groupAccount!
                                                      .infoTopicRegisterList![0]
                                                      .teacher !=
                                                  null
                                              ? Text(
                                                  widget
                                                      .student
                                                      .groupAccount!
                                                      .infoTopicRegisterList![0]
                                                      .teacher,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                )
                                              : const Text(
                                                  'Chưa có giáo viên',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ))
                                          : const Text('Chưa có đề tài',
                                              style: TextStyle(fontSize: 16)))
                                      : const Text('Chưa có nhóm',
                                          style: TextStyle(fontSize: 16)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 20,
                  top: -3,
                  child: Text(
                    'Thông tin đề tài',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
