import 'package:flutter/material.dart';
import 'login_page.dart';
import 'reset_password_page.dart';
import 'dart:convert';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();

  bool isResetPassword = false;
  if (args.length > 2) {
    try {
      final data = jsonDecode(args[2]);
      if (data is List && data.isNotEmpty && data[0] == 'reset_password') {
        isResetPassword = true;
      }
    } catch (e) {
      // ignore
    }
  }

  if (isResetPassword) {
    runApp(const ResetPasswordApp());
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class ResetPasswordApp extends StatelessWidget {
  const ResetPasswordApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResetPasswordPage(),
    );
  }
}