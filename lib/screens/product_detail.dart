import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/product.dart';
import '../theme/app_theme.dart';
import '../widgets/left_drawer.dart';

const Map<String, String> _detailCategoryLabels = {
  'ball': 'Ball',
  'jersey': 'Jersey',
  'shoes': 'Shoes',
  'socks': 'Socks',
  'shin_guards': 'Shin Guards',
  'goalkeeper_gloves': 'Goalkeeper Gloves',
  'training_equipment': 'Training Equipment',
  'bag': 'Bag',
  'accessories': 'Accessories',
  'other': 'Other',
};

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    final dateFormatter = DateFormat('dd MMM yyyy HH:mm');
    String formatDate(DateTime? value) =>
        value != null ? dateFormatter.format(value.toLocal()) : '-';
    final categoryLabel =
        _detailCategoryLabels[product.category] ??
        product.category.replaceAll('_', ' ');
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.blueGrey.shade50,
                  child: product.thumbnail != null
                      ? Image.network(
                          product.thumbnail!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.broken_image, size: 48),
                        )
                      : const Icon(
                          Icons.image_not_supported_outlined,
                          size: 48,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      formatter.format(product.price),
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: BrandColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: [
                        Chip(
                          avatar: const Icon(Icons.category, size: 16),
                          label: Text(categoryLabel),
                        ),
                        Chip(
                          avatar: const Icon(Icons.sell_outlined, size: 16),
                          label: Text(product.brand),
                        ),
                        Chip(
                          avatar: const Icon(
                            Icons.inventory_2_outlined,
                            size: 16,
                          ),
                          label: Text('Stok ${product.stock}'),
                        ),
                        Chip(
                          avatar: const Icon(
                            Icons.verified_user_outlined,
                            size: 16,
                          ),
                          label: Text(product.ownerUsername ?? '67 Sportswear'),
                        ),
                        Chip(
                          avatar: Icon(
                            product.isFeatured ? Icons.star : Icons.star_border,
                            size: 16,
                            color: product.isFeatured
                                ? Colors.amber
                                : Colors.grey,
                          ),
                          label: Text(
                            product.isFeatured ? 'Unggulan' : 'Regular',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deskripsi Produk',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: BrandColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detail Teknis',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(label: 'ID Produk', value: product.id),
                    _DetailRow(
                      label: 'Pemilik',
                      value: product.ownerUsername ?? '-',
                    ),
                    _DetailRow(
                      label: 'Dibuat',
                      value: formatDate(product.createdAt),
                    ),
                    _DetailRow(
                      label: 'Diperbarui',
                      value: formatDate(product.updatedAt),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke daftar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
