import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _idController = TextEditingController();
  final _pwController = TextEditingController();
  final _newPwController = TextEditingController();
  final _confirmPwController = TextEditingController();

  bool _loginSuccess = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // 창 크기 고정(예시: 500x300)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupWindow();
    });
  }

  Future<void> _setupWindow() async {
    await windowManager.ensureInitialized();
    await windowManager.setSize(const Size(500, 300));
    await windowManager.setMinimumSize(const Size(500, 300));
    await windowManager.setMaximumSize(const Size(500, 300));
    await windowManager.center();
  }

  Future<bool> _login(String id, String pw) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return id == 'test' && pw == 'test';
  }

  Future<void> _changePassword(String newPw) async {
    await Future.delayed(const Duration(milliseconds: 500));
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
              Navigator.of(context).pop();
              Navigator.of(context).maybePop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double inputWidth = 220;

    return Scaffold(
      appBar: AppBar(
        title: const Text('비밀번호 재설정'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: SizedBox(
          width: 460,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_loginSuccess) ...[
                TextField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    labelText: "ID",
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _pwController,
                  decoration: const InputDecoration(
                    labelText: "PW",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: inputWidth,
                  height: 38,
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
                        : const Text('로그인', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ),
              ] else ...[
                TextField(
                  controller: _newPwController,
                  decoration: const InputDecoration(
                    labelText: "새 비밀번호",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _confirmPwController,
                  decoration: const InputDecoration(
                    labelText: "비밀번호 확인",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: inputWidth,
                  height: 38,
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
                        : const Text('저장', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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