import 'package:cdio_project/controller/student_controller.dart';
import 'package:cdio_project/model/student/student.dart';
import 'package:cdio_project/model/student/student_update.dart';
import 'package:cdio_project/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

class StudentEditInfo extends ConsumerStatefulWidget {
  const StudentEditInfo({super.key, required this.student});

  final Student student;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => StudentEidtInfoState();
}

class StudentEidtInfoState extends ConsumerState<StudentEditInfo> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController dateOfBirthController = TextEditingController();

  String name = '';
  String dateOfBirth = '';
  String address = '';
  String phone = '';
  String mail = '';
  bool gender = true;
  bool isPickedDate = false;

  void _updateStudent() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận'),
        content: const Text('Bạn có chắc muốn cập nhật sinh viên này không'),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              formKey.currentState!.save();
              await StudentController().updateStudent(
                StudentUpdate(
                  studentId: widget.student.studentId,
                  name: name,
                  dateOfBirth: dateOfBirth,
                  address: address,
                  phone: phone,
                  email: mail,
                  avatar: widget.student.avatar,
                  gender: gender,
                  grade: 1,
                ),
              );
              if (mounted) {
                // ignore: unused_result
                ref.refresh(studentProvider);
                Navigator.of(context).pop();
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

  @override
  void initState() {
    dateOfBirthController.text = widget.student.dateOfBirth.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: const Text(
              'Chỉnh sửa sinh viên',
              style: TextStyle(
                fontSize: 23,
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
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        widget.student.studentId.toString(),
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
                                      padding: const EdgeInsets.only(right: 10),
                                      child: SizedBox(
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: TextFormField(
                                          initialValue: widget.student.name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          textAlign: TextAlign.right,
                                          onSaved: (newValue) {
                                            name = newValue!;
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
                                      print(dateOfBirth);
                                    },
                                    icon: Image.asset(
                                      'assets/icons/birthday.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: SizedBox(
                                      height: 70,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: TextFormField(
                                        controller: dateOfBirthController,
                                        // initialValue: widget.student.dateOfBirth,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        textAlign: TextAlign.right,
                                        onSaved: (newValue) {
                                          dateOfBirth = newValue!;
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
                                    padding: const EdgeInsets.only(right: 10),
                                    child: SizedBox(
                                      height: 70,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: TextFormField(
                                        initialValue: widget.student.address,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        textAlign: TextAlign.right,
                                        onSaved: (newValue) {
                                          address = newValue!;
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
                                    padding: const EdgeInsets.only(right: 10),
                                    child: SizedBox(
                                      height: 70,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: TextFormField(
                                        initialValue: widget.student.phone,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        textAlign: TextAlign.right,
                                        onSaved: (newValue) {
                                          phone = newValue!;
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
                                    padding: const EdgeInsets.only(right: 10),
                                    child: SizedBox(
                                      height: 70,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: TextFormField(
                                        initialValue: widget.student.email,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        textAlign: TextAlign.right,
                                        onSaved: (newValue) {
                                          mail = newValue!;
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
                                    padding: const EdgeInsets.only(right: 10),
                                    child: SizedBox(
                                      height: 70,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: TextFormField(
                                        initialValue: widget.student.gender
                                            ? 'Nam'
                                            : 'Nữ',
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.black),
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
              height: 10,
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
                      onPressed: _updateStudent,
                      icon: Image.asset('assets/icons/edit.png'),
                      label: const Text('Cập nhật')),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                      style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(9)),
                      onPressed: () {},
                      icon: Image.asset('assets/icons/delete.png'),
                      label: const Text('Xóa')),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
