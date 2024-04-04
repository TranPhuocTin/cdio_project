  import 'package:cdio_project/view/admin/profile.dart';
  import 'package:cdio_project/view/admin/student.dart';
  import 'package:cdio_project/view/admin/teacher.dart';
  import 'package:flutter/material.dart';

  class MainScreen extends StatefulWidget {
    const MainScreen({required this.token, super.key});
    final String token;
    @override
    State<MainScreen> createState() => _MainScreenState();
  }

  class _MainScreenState extends State<MainScreen> {
    bool loginStatus = false;
    int _selectedIndex = 0;

    final List<Widget> _adminScreens = <Widget>[
      const ManageTeacherScreen(),
      const ManageStudentScreen(),
      const ProfileScreen(),
    ];

    final List<String> _appBarTitle = <String>[
      'Danh sách giảng viên',
      'Danh sách sinh viên',
      'Cài đặt',
    ];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(title: Text(_appBarTitle.elementAt(_selectedIndex)),),
        body: _adminScreens.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Giảng Viên',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Sinh Viên',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Hồ sơ',
            ),
          ],
          selectedItemColor: Colors.amber[800],
          currentIndex: _selectedIndex,
          onTap: (value) => setState(() {
            _selectedIndex = value;
          },),
        ),
      );
    }
  }
