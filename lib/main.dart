import 'package:cdio_project/firebase_options.dart';
import 'package:cdio_project/theme/text_theme.dart';
import 'package:cdio_project/theme/theme.dart';
import 'package:cdio_project/view/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  const MaterialTheme myAppTheme = MaterialTheme(textTheme);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(
      child: MyApp(
        myAppTheme: myAppTheme,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.myAppTheme}) : super(key: key);

  final MaterialTheme myAppTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: myAppTheme.light(), // or myAppTheme.dark(), etc.
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const Login(),
    );
  }
}
