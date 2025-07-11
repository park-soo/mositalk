import 'package:flutter/material.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'dart:convert';

void main(List<String> args) {
    print('=== args ===');
  for (int i = 0; i < args.length; i++) {
    print('args[$i]: ${args[i]}');
  }
  WidgetsFlutterBinding.ensureInitialized();

  bool isSub = false;
  if (args.length > 2) {
    try {
      final data = jsonDecode(args[2]);
      if (data is List && data.isNotEmpty && data[0] == 'sub') {
        isSub = true;
      }
    } catch (e) {
      // ignore
    }
  }

  if (isSub) {
    runApp(const MaterialApp(home: SubWindow()));
  } else {
    runApp(const MaterialApp(home: MainWindow()));
  }
}

class MainWindow extends StatelessWidget {
  const MainWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('메인 창')),
      body: Center(
        child: ElevatedButton(
          child: const Text('새 창 열기'),
          onPressed: () async {
            final window = await DesktopMultiWindow.createWindow(
              jsonEncode(['sub']),
            );
            window
              ..setTitle('서브 창')
              ..show();
          },
        ),
      ),
    );
  }
}

class SubWindow extends StatelessWidget {
  const SubWindow({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('서브 창')),
      body: const Center(child: Text('이것은 새 창입니다!')),
    );
  }
}