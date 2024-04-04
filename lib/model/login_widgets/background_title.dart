import 'package:flutter/material.dart';

class BackgroundAndTitle extends StatelessWidget {
  const BackgroundAndTitle({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.57,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          const Color(0xFF0029FF),
          const Color(0xCA9295CA).withOpacity(0.57)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.07),
          const Text(
            'Graduation Thesis \nManagement',
            style: TextStyle(
              color: Color(0xFFF6F6F6),
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 135,
            width: 160,
            child: Image.asset(
              'assets/icons/school.png',
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.1),
            child: const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Login',
                style: TextStyle(
                  color: Color(0xFFF6F6F6),
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
