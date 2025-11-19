import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../services/api_config.dart';
import 'home.dart';
import 'register.dart';

class LoginPage extends StatefulWidget { 
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit(CookieRequest request) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    final response = await request.login(ApiConfig.resolve('/auth/login/'), {
      'username': _usernameController.text.trim(),
      'password': _passwordController.text,
    });
    setState(() => _isSubmitting = false);
    if (!mounted) return;

    final success = request.loggedIn;
    final message =
        response['message'] ?? (success ? 'Login sukses.' : 'Login gagal.');
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message.toString())));

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F1E3C), Color(0xFF122551)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const SizedBox(height: 24),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Login',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _usernameController,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                labelText: 'Username',
                                hintText: 'esportswear67',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Username wajib diisi';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                hintText: '********',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password wajib diisi';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: _isSubmitting
                                    ? null
                                    : () => _submit(request),
                                child: _isSubmitting
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text('Masuk'),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: _isSubmitting
                                    ? null
                                    : () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const RegisterPage(),
                                          ),
                                        );
                                      },
                                child: const Text(
                                  'Belum punya akun? Daftar sekarang',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
