import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';
import '../widgets/left_drawer.dart';
import 'product_form.dart';
import 'product_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final username = (request.jsonData['username'] as String?)?.trim();
    final greetingName = (username?.isNotEmpty ?? false) ? username! : 'Atlet';

    return Scaffold(
      appBar: AppBar(title: const Text('67 Sportswear')),
      drawer: const LeftDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF7F9FF), Color(0xFFEFF3FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                _HeroSection(greetingName: greetingName),
                const SizedBox(height: 24),
                _ActionGrid(
                  onAllProducts: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProductListPage(),
                      ),
                    );
                  },
                  onMyProducts: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProductListPage(mineOnly: true),
                      ),
                    );
                  },
                  onCreateProduct: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProductFormPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.greetingName});

  final String greetingName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [BrandColors.primary, Color(0xFF2563EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Halo, $greetingName',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '67 Sportswear Catalog',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Browse and manage the latest products from the community.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 20,
            runSpacing: 12,
            children: const [
              _HeroHighlight(label: '67', caption: 'Brand Number'),
              _HeroHighlight(label: '24/7', caption: 'Katalog Sinkron'),
              _HeroHighlight(label: '100+', caption: 'Produk Tersimpan'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroHighlight extends StatelessWidget {
  const _HeroHighlight({required this.label, required this.caption});

  final String label;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          caption,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid({
    required this.onAllProducts,
    required this.onMyProducts,
    required this.onCreateProduct,
  });

  final VoidCallback onAllProducts;
  final VoidCallback onMyProducts;
  final VoidCallback onCreateProduct;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 650;
        final children = [
          _ActionCard(
            title: 'Semua Produk',
            description:
                'Telusuri katalog lengkap 67 Sportswear yang sinkron dengan Django.',
            icon: Icons.view_module_outlined,
            backgroundColor: Colors.white,
            iconColor: BrandColors.textPrimary,
            borderColor: BrandColors.success,
            onTap: onAllProducts,
          ),
          _ActionCard(
            title: 'Produk Saya',
            description:
                'Lihat koleksi yang kamu unggah dan perbarui stok secara instan.',
            icon: Icons.badge_outlined,
            backgroundColor: Colors.white,
            iconColor: BrandColors.textPrimary,
            borderColor: BrandColors.primary,
            onTap: onMyProducts,
          ),
          _ActionCard(
            title: 'Tambah Produk',
            description:
                'Masukkan item baru lengkap dengan detail, thumbnail, dan kategori.',
            icon: Icons.add_circle_outline,
            backgroundColor: Colors.white,
            iconColor: BrandColors.accent,
            borderColor: BrandColors.accent,
            onTap: onCreateProduct,
          ),
        ];

        if (isWide) {
          return Row(
            children: [
              Expanded(child: children[0]),
              const SizedBox(width: 16),
              Expanded(child: children[1]),
              const SizedBox(width: 16),
              Expanded(child: children[2]),
            ],
          );
        }

        return Column(
          children: [
            children[0],
            const SizedBox(height: 16),
            children[1],
            const SizedBox(height: 16),
            children[2],
          ],
        );
      },
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.borderColor,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final Color borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: BrandColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: BrandColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
