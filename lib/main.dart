import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'login_page.dart';
import 'reset_password_page.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  if (args.isNotEmpty && args.first == 'reset_password') {
    runApp(const ResetPasswordApp());
    return;
  }

  WindowOptions windowOptions = const WindowOptions(
    size: Size(280, 420),
    center: true,
    minimumSize: Size(280, 420),
    maximumSize: Size(280, 420),
    title: 'Mositalk',
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
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