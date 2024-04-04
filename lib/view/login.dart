import 'package:cdio_project/controller/auth_controller.dart';
import 'package:cdio_project/model/login_widgets/background_title.dart';
import 'package:cdio_project/model/login_widgets/divider_login.dart';
import 'package:cdio_project/model/login_widgets/other_logintype.dart';
import 'package:cdio_project/model/user/roles.dart';
import 'package:cdio_project/theme/color.dart';
import 'package:cdio_project/view/main_screen.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login1State();
}

class _Login1State extends State<Login> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  String userNameErrorText = '';
  String passErrorText = '';
  bool obscurePassword = true;
  bool isRemember = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    void login(BuildContext context) async {
      try {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          await AuthController.login(username, password, isRemember);
          final token = await AuthController.readToken();
          if (!context.mounted) return;
          if ((token != null || token != '') && context.mounted ) {
            if(userRoles.any((element) => element['authority'] == 'ROLE_ADMIN')){
              Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => MainScreen(
                  token: token ?? '',
                ),
              ),
            );
            }
          }
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          color: const Color(0xFFFFFFFF),
          child: Stack(
            children: [
              Positioned(
                top: 0, 
                left: 0,
                right: 0,
                child: BackgroundAndTitle(height: height, width: width),
              ),
              Positioned(
                top: 325,
                left: 22,
                right: 22,
                child: Container(
                  height: height * 0.53,
                  width: width * 0.88,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ],
                    color: const Color(0xffF6F6F6),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 30),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'Username',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //Email TextField
                          Container(
                            width: MediaQuery.of(context).size.width * 0.844,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: colors['onTextField'],
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                    color: const Color(0xff000000)
                                        .withOpacity(0.25),
                                    offset: const Offset(0, 3)),
                              ],
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                fillColor: colors['onTextField'],
                                prefixIcon: const Icon(Icons.mail),
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '   Username is required!';
                                }
                                return null; // Return null if the input is valid
                              },
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  username = newValue;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'Password',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //Password TextField
                          Container(
                            width: MediaQuery.of(context).size.width * 0.844,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: colors['onTextField'],
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                    color: const Color(0xff000000)
                                        .withOpacity(0.25),
                                    offset: const Offset(0, 3)),
                              ],
                            ),
                            child: TextFormField(
                              obscureText: obscurePassword,
                              decoration: InputDecoration(
                                fillColor: colors['onTextField'],
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscurePassword = !obscurePassword;
                                      });
                                    },
                                    icon: Icon(obscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '   Username is required!';
                                }
                                return null; // Return null if the input is valid
                              },
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  password = newValue;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: isRemember,
                                    onChanged: (value) {
                                      setState(() {
                                        isRemember = value!;
                                      });
                                    },
                                    checkColor: colors['inCheckBox'],
                                    activeColor: colors['checkBox'],
                                  ),
                                  Text(
                                    'Remember Me',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(fontSize: 13),
                                  ))
                            ],
                          ),
                          Center(
                            child: InkWell(
                              onTap: () => login(context),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.0425,
                                width:
                                    MediaQuery.of(context).size.width * 0.5777,
                                decoration: BoxDecoration(
                                    color: colors['login'],
                                    borderRadius: BorderRadius.circular(6)),
                                child: Center(
                                    child: Text(
                                  'Login',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              SizedBox(
                                width: 50,
                              ),
                              DividerLogin(),
                              Text(
                                '  Or  ',
                                style: TextStyle(color: Colors.black),
                              ),
                              DividerLogin(),
                              SizedBox(
                                width: 50,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: const OtherLoginType(
                                      image: 'assets/icons/google.png'),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const OtherLoginType(
                                      image: 'assets/icons/facebook.png'),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const OtherLoginType(
                                      image: 'assets/icons/mydtu.png'),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: (Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .fontSize)! +
                                          2,
                                      fontWeight: FontWeight.bold,
                                      color: colors['signup']),
                                ),
                              )
                            ],
                          )
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
    );
  }
}
