import 'package:flutter/material.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  // 1단계
  final _idController = TextEditingController();
  final _pwController = TextEditingController();

  // 2단계
  final _newPwController = TextEditingController();
  final _confirmPwController = TextEditingController();

  bool _loginSuccess = false;
  bool _isLoading = false;

  // 데모 로그인 (id, pw가 둘 다 'test'면 성공)
  Future<bool> _login(String id, String pw) async {
    await Future.delayed(const Duration(milliseconds: 500)); // fake delay
    return id == 'test' && pw == 'test';
  }

  // 비밀번호 변경 로직 (실제 서비스 연동 시 함수 변경)
  Future<void> _changePassword(String newPw) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // 실제 비밀번호 변경 처리
  }

  void _showPasswordChangedDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("완료"),
        content: const Text("비밀번호가 변경되었습니다."),
        actions: [
          TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // 다이얼로그 닫기
            Navigator.of(context).maybePop(); // 창 닫기 (최상위라면 윈도우 닫힘)
          },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double pageWidth = 330 * 2; // 로그인 페이지의 2배 정도
    final double inputWidth = 320 * 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('비밀번호 재설정'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Container(
          width: pageWidth,
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_loginSuccess) ...[
                // 1단계: 로그인
                TextField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    labelText: "ID",
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _pwController,
                  decoration: const InputDecoration(
                    labelText: "PW",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: inputWidth / 2,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            setState(() => _isLoading = true);
                            final success = await _login(
                              _idController.text,
                              _pwController.text,
                            );
                            setState(() => _isLoading = false);
                            if (success) {
                              setState(() => _loginSuccess = true);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('로그인에 실패했습니다.')),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Text('로그인', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
              ] else ...[
                // 2단계: 비밀번호 재설정
                TextField(
                  controller: _newPwController,
                  decoration: const InputDecoration(
                    labelText: "새 비밀번호",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _confirmPwController,
                  decoration: const InputDecoration(
                    labelText: "비밀번호 확인",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: inputWidth / 2,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            final newPw = _newPwController.text;
                            final confirmPw = _confirmPwController.text;
                            if (newPw.isEmpty || confirmPw.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('모든 필드를 입력하세요.')),
                              );
                              return;
                            }
                            if (newPw != confirmPw) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('비밀번호가 일치하지 않습니다.')),
                              );
                              return;
                            }
                            setState(() => _isLoading = true);
                            await _changePassword(newPw);
                            setState(() => _isLoading = false);
                            _showPasswordChangedDialog();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Text('저장', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}