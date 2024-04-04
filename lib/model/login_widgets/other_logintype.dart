import 'package:flutter/material.dart';

class OtherLoginType extends StatelessWidget {
  final String image;

  const OtherLoginType({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Image.asset(image),
    );
  }
}
