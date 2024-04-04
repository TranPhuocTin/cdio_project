import 'package:cdio_project/theme/color.dart';
import 'package:flutter/material.dart';

class DividerLogin extends StatelessWidget {
  const DividerLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Divider(
        height: 2,
        color: colors['divider'],
        thickness: 2,
      ),
    );
  }
}
