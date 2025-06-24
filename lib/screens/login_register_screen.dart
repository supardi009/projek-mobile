import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRegisterScreen extends StatefulWidget {
  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoginMode = true;

  Future<void> _handleAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (_isLoginMode) {
      // Login
      final savedUser = prefs.getString('user') ?? '';
      final savedPass = prefs.getString('pass') ?? '';
      if (username == savedUser && password == savedPass) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showDialog('Login gagal! Periksa kembali data Anda.');
      }
    } else {
      // Register
      await prefs.setString('user', username);
      await prefs.setString('pass', password);
      _showDialog('Registrasi berhasil! Silakan login.');
      setState(() {
        _isLoginMode = true;
      });
    }
  }

  void _showDialog(String msg) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            content: Text(msg),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginMode ? 'Login' : 'Register'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _isLoginMode = !_isLoginMode);
            },
            child: Text(
              _isLoginMode ? 'Daftar' : 'Login',
              style: TextStyle(color: Colors.yellow),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _handleAuth,
              child: Text(_isLoginMode ? 'Login' : 'Register'),
            ),
          ],
        ),
      ),
    );
  }
}
