import 'package:cdio_project/theme/color.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final Icon icon;

  const LoginTextField({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.844,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: colors['onTextField'],
        boxShadow: [
          BoxShadow(
              blurRadius: 2,
              spreadRadius: 0,
              color: const Color(0xff000000).withOpacity(0.25),
              offset: const Offset(0, 3)),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
            fillColor: colors['onTextField'],
            prefixIcon: icon,
            border: InputBorder.none
            // enabled: true,
            ),
      ),
    );
  }
}
