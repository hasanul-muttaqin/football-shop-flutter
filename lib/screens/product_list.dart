import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../services/api_config.dart';
import '../theme/app_theme.dart';
import '../widgets/left_drawer.dart';
import 'product_detail.dart';

const Map<String, String> _categoryLabels = {
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

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key, this.mineOnly = false});

  final bool mineOnly;

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> _productsFuture;
  bool _initialized = false;
  late CookieRequest _request;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _request = context.read<CookieRequest>();
      _productsFuture = _fetchProducts();
      _initialized = true;
    }
  }

  Future<List<Product>> _fetchProducts() async {
    final suffix = widget.mineOnly ? '/json/?mine=1' : '/json/';
    final result = await _request.get(ApiConfig.resolve(suffix));
    if (result is Map && result['detail'] != null) {
      throw Exception(result['detail']);
    }
    final rawList = List<Map<String, dynamic>>.from(result as List);
    return rawList.map(Product.fromJson).toList();
  }

  Future<void> _refresh() async {
    setState(() {
      _productsFuture = _fetchProducts();
    });
    await _productsFuture;
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mineOnly ? 'Produk Saya' : 'Semua Produk'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return _ErrorState(
              message: snapshot.error.toString(),
              onRetry: _refresh,
            );
          }
          final products = snapshot.data ?? [];
          if (products.isEmpty) {
            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(24),
                children: [
                  _ListHeader(
                    mineOnly: widget.mineOnly,
                    total: products.length,
                  ),
                  const SizedBox(height: 40),
                  const _EmptyState(),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              itemCount: products.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _ListHeader(
                    mineOnly: widget.mineOnly,
                    total: products.length,
                  );
                }
                final product = products[index - 1];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: _ProductListCard(
                    product: product,
                    formatter: formatter,
                    categoryLabel: _categoryLabel(product.category),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailPage(product: product),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  String _categoryLabel(String slug) {
    final direct = _categoryLabels[slug];
    if (direct != null) return direct;
    final pretty = slug.replaceAll('_', ' ');
    return pretty
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }
}

class _ListHeader extends StatelessWidget {
  const _ListHeader({required this.mineOnly, required this.total});

  final bool mineOnly;
  final int total;

  @override
  Widget build(BuildContext context) {
    final title = mineOnly ? 'Koleksi Saya' : 'Katalog 67 Sportswear';
    final subtitle = mineOnly
        ? 'Produk yang kamu buat langsung dari Flutter & Django.'
        : 'Semua produk yang disediakan oleh komunitas 67 Sportswear.';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE1E6F5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: mineOnly
                      ? BrandColors.primary.withOpacity(0.1)
                      : Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  mineOnly ? 'Private view' : 'Global view',
                  style: TextStyle(
                    color: mineOnly
                        ? BrandColors.primary
                        : Colors.blue.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$total produk',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: BrandColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: BrandColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: BrandColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _ProductListCard extends StatelessWidget {
  const _ProductListCard({
    required this.product,
    required this.formatter,
    required this.categoryLabel,
    required this.onTap,
  });

  final Product product;
  final NumberFormat formatter;
  final String categoryLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final image = product.thumbnail;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(26),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: const Color(0xFFE1E6F5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(26),
                bottomLeft: Radius.circular(26),
              ),
              child: Container(
                width: 130,
                height: 150,
                color: Colors.blueGrey.shade50,
                child: image != null
                    ? Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image, size: 32),
                      )
                    : const Icon(Icons.image_not_supported_outlined, size: 32),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatter.format(product.price),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: BrandColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: BrandColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        Chip(
                          label: Text(categoryLabel),
                          avatar: const Icon(Icons.category, size: 16),
                        ),
                        Chip(
                          label: Text(product.brand),
                          avatar: const Icon(Icons.sell_outlined, size: 16),
                        ),
                        Chip(
                          label: Text('Stok ${product.stock}'),
                          avatar: const Icon(
                            Icons.inventory_2_outlined,
                            size: 16,
                          ),
                        ),
                        if (product.isFeatured)
                          const Chip(
                            label: Text('Unggulan'),
                            avatar: Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                          ),
                      ],
                    ),
                    if (product.ownerUsername != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        'Dibuat oleh ${product.ownerUsername}',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: BrandColors.textMuted),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE1E6F5)),
      ),
      child: Column(
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: BrandColors.primary,
            ),
            alignment: Alignment.center,
            child: const Text(
              '67',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada produk',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Tambah item baru dari halaman beranda untuk menampilkan katalog di sini.',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: BrandColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: BrandColors.accent,
                ),
                const SizedBox(height: 12),
                Text(
                  'Gagal memuat data',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: onRetry,
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
