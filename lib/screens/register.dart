import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../services/api_config.dart';
import '../theme/app_theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit(CookieRequest request) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    final response = await request.postJson(
      ApiConfig.resolve('/auth/register/'),
      jsonEncode({
        'username': _usernameController.text.trim(),
        'password1': _passwordController.text,
        'password2': _confirmController.text,
      }),
    );
    setState(() => _isSubmitting = false);
    if (!mounted) return;
    final success = response['status'] == true;
    final errors = response['errors'];
    final message = success
        ? 'Registrasi berhasil! Silakan masuk.'
        : (errors?.toString() ?? 'Registrasi gagal');

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));

    if (success) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Akun 67 Sportswear')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Buat profil baru',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Akses katalog Django & Flutter dengan kredensial tunggal.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: BrandColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: const [
                          _BenefitChip(label: 'Sinkron otomatis'),
                          _BenefitChip(label: 'Inventaris aman'),
                          _BenefitChip(label: 'Panel mobile + web'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          hintText: 'esportswear67',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Username wajib diisi';
                          }
                          if (value.trim().length < 4) {
                            return 'Minimal 4 karakter';
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
                          hintText: 'Minimal 8 karakter',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password wajib diisi';
                          }
                          if (value.length < 8) {
                            return 'Minimal 8 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Konfirmasi Password',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Konfirmasi password wajib diisi';
                          }
                          if (value != _passwordController.text) {
                            return 'Password tidak sama';
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
                              : const Text('Daftar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BenefitChip extends StatelessWidget {
  const _BenefitChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      avatar: const Icon(
        Icons.check_circle,
        size: 16,
        color: BrandColors.primary,
      ),
    );
  }
}
