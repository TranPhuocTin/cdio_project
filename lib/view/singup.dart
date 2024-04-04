import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height *0.7,
        width: double.infinity,
        color: Colors.lightBlueAccent,
      ),
    );
  }
}
