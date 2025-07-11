import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:window_manager/window_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _savePassword = false;

    @override
  void initState() {
    super.initState();
    _setupWindow();
  }

  Future<void> _setupWindow() async {
    await windowManager.ensureInitialized();
    await windowManager.setSize(const Size(280, 420));
    await windowManager.setMinimumSize(const Size(280, 420));
    await windowManager.setMaximumSize(const Size(280, 420));
    await windowManager.center();
  }

  void _launchHomePage() async {
    final url = Uri.parse('http://www.mobilitysystems.kr');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    const double inputWidth = 166;
    const double ipWidth = 95;
    const double portWidth = 45;
    const double gapWidth = 2;

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 8),
                    Image.asset('assets/icon_32.png'),
                    Text(
                      'Mositalk',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: inputWidth,
                    child: Row(
                      children: [
                        SizedBox(
                          width: ipWidth,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '서버 IP',
                              hintStyle: TextStyle(fontSize: 11),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                              isDense: true,
                            ),
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        SizedBox(width: gapWidth),
                        SizedBox(
                          width: portWidth,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Port',
                              hintStyle: TextStyle(fontSize: 11),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                              isDense: true,
                            ),
                            style: TextStyle(fontSize: 10),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: IconButton(
                            icon: Icon(Icons.search, size: 16, color: Colors.deepPurple),
                            padding: EdgeInsets.zero,
                            splashRadius: 12,
                            constraints: BoxConstraints(
                              minWidth: 24,
                              minHeight: 24,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: SizedBox(
                    width: inputWidth,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'ID',
                        hintStyle: TextStyle(fontSize: 11),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                        contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        isDense: true,
                      ),
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: SizedBox(
                    width: inputWidth,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'PW',
                        hintStyle: TextStyle(fontSize: 11),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
                        contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        isDense: true,
                      ),
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: inputWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 0.7,
                          child: Checkbox(
                            value: _savePassword,
                            onChanged: (value) {
                              setState(() {
                                _savePassword = value ?? false;
                              });
                            },
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _savePassword = !_savePassword;
                            });
                          },
                          child: const Text('패스워드 저장', style: TextStyle(fontSize: 11)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: inputWidth / 3,
                      height: 33,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Text(
                          '취소',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    SizedBox(
                      width: inputWidth * 2 / 3,
                      height: 33,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Text(
                          '로그인',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextButton(
                onPressed: () async {
    final window = await DesktopMultiWindow.createWindow(
      jsonEncode(['reset_password']),
    );
    window
      ..setTitle('비밀번호 재설정')
      ..show();
  },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: const Size(0, 28),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  '비밀번호 재설정',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 20,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: _launchHomePage,
                child: const Text(
                  'www.mobilitysystems.kr',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // 원격지원요청 액션
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  '원격지원요청',
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
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