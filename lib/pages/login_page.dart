import 'package:flutter/material.dart';
import '../services/app_storage.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onLogin;

  const LoginPage({super.key, required this.onLogin});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AppStorage _appStorage = AppStorage();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();

  @override
  void dispose() {
    _usernameController.clear();
    _passwordControler.clear();
    super.dispose();
  }

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordControler.text.trim();
    final isValid = await _appStorage.validateLogin(username, password);

    if (!mounted) {
      return;
    }

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuários ou senha incorretos.')),
      );

      return;
    }

    await _appStorage.setLoggedIn(true);
    widget.onLogin();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 72,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Minhas Tarefas',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
