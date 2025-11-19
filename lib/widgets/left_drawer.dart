import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../screens/home.dart';
import '../screens/login.dart';
import '../screens/product_form.dart';
import '../screens/product_list.dart';
import '../services/api_config.dart';
import '../theme/app_theme.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  Future<void> _logout(BuildContext context, CookieRequest request) async {
    final navigator = Navigator.of(context);
    await request.logout(ApiConfig.resolve('/auth/logout/'));
    if (!navigator.mounted) return;
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
      child: Container(
        color: BrandColors.surface,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [BrandColors.primary, BrandColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    '67 Sportswear',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Kurasi perlengkapan sepak bola profesionalmu.',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),
            _DrawerItem(
              icon: Icons.home_outlined,
              label: 'Beranda',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
            ),
            _DrawerItem(
              icon: Icons.view_module_outlined,
              label: 'Semua Produk',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ProductListPage()),
                );
              },
            ),
            _DrawerItem(
              icon: Icons.verified_user_outlined,
              label: 'Produk Saya',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProductListPage(mineOnly: true),
                  ),
                );
              },
            ),
            _DrawerItem(
              icon: Icons.add_box_outlined,
              label: 'Tambah Produk',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ProductFormPage()),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(height: 32),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: BrandColors.accent),
              title: const Text(
                'Keluar',
                style: TextStyle(
                  color: BrandColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () => _logout(context, request),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: BrandColors.primary),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      onTap: onTap,
    );
  }
}
