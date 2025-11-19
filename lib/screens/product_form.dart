import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../services/api_config.dart';
import '../theme/app_theme.dart';
import '../widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _brand = '';
  String _description = '';
  String _category = 'ball';
  String _thumbnail = '';
  bool _isFeatured = false;
  String _priceRaw = '';
  String _stockRaw = '';
  bool _isSubmitting = false;

  final List<_CategoryOption> _categories = const [
    _CategoryOption(value: 'ball', label: 'Ball'),
    _CategoryOption(value: 'jersey', label: 'Jersey'),
    _CategoryOption(value: 'shoes', label: 'Shoes'),
    _CategoryOption(value: 'socks', label: 'Socks'),
    _CategoryOption(value: 'shin_guards', label: 'Shin Guards'),
    _CategoryOption(value: 'goalkeeper_gloves', label: 'Goalkeeper Gloves'),
    _CategoryOption(value: 'training_equipment', label: 'Training Equipment'),
    _CategoryOption(value: 'bag', label: 'Bag'),
    _CategoryOption(value: 'accessories', label: 'Accessories'),
    _CategoryOption(value: 'other', label: 'Other'),
  ];

  int? get _price => int.tryParse(_priceRaw);
  int? get _stock => int.tryParse(_stockRaw);

  bool _isValidUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null && uri.hasScheme && uri.hasAuthority;
  }

  Future<void> _handleSubmit(CookieRequest request) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    final payload = jsonEncode({
      'name': _name.trim(),
      'brand': _brand.trim(),
      'description': _description.trim(),
      'category': _category,
      'thumbnail': _thumbnail.trim(),
      'price': _price,
      'stock': _stock,
      'is_featured': _isFeatured,
    });
    final response = await request.postJson(
      ApiConfig.resolve('/products/create-mobile/'),
      payload,
    );
    setState(() => _isSubmitting = false);
    if (!mounted) return;

    if (response['status'] == true) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Produk berhasil disimpan'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dialogRow('Nama', _name),
                _dialogRow('Brand', _brand),
                _dialogRow('Harga', 'Rp ${_price ?? 0}'),
                _dialogRow('Kategori', _categoryLabel(_category)),
                _dialogRow('Stok', '${_stock ?? 0} unit'),
                _dialogRow('Unggulan', _isFeatured ? 'Ya' : 'Tidak'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _resetForm();
                },
                child: const Text('Sip, lanjut'),
              ),
            ],
          );
        },
      );
    } else {
      final detail = response['detail'] ?? response.toString();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Gagal menyimpan: $detail')));
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _name = '';
      _brand = '';
      _description = '';
      _category = 'ball';
      _thumbnail = '';
      _isFeatured = false;
      _priceRaw = '';
      _stockRaw = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Produk 67 Sportswear')),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [BrandColors.primary, BrandColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '67 Sportswear Product Lab',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Pastikan seluruh field mengikuti model Django agar sinkron dengan dashboard web.',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: const [
                        _GuideChip(label: 'Validasi angka & URL'),
                        _GuideChip(label: 'Kategori sama dengan Django'),
                        _GuideChip(label: 'Simpan sebagai produk unggulan'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionTitle('Identitas Produk'),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Nama Produk',
                        hint: 'Contoh: Velocity Elite 3.0',
                        onChanged: (value) => setState(() => _name = value),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          if (value.trim().length < 3) {
                            return 'Nama minimal 3 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Brand',
                        hint: 'Contoh: 67 Sportswear Labs',
                        onChanged: (value) => setState(() => _brand = value),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Brand tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      _SectionTitle('Inventaris & Detail'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              label: 'Harga (Rp)',
                              hint: 'cth: 950000',
                              keyboardType: TextInputType.number,
                              onChanged: (value) =>
                                  setState(() => _priceRaw = value),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Harga tidak boleh kosong';
                                }
                                final parsed = int.tryParse(value);
                                if (parsed == null) {
                                  return 'Harga harus berupa angka bulat';
                                }
                                if (parsed <= 0) {
                                  return 'Harga harus lebih dari 0';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              label: 'Stok',
                              hint: 'cth: 24',
                              keyboardType: TextInputType.number,
                              onChanged: (value) =>
                                  setState(() => _stockRaw = value),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Stok tidak boleh kosong';
                                }
                                final parsed = int.tryParse(value);
                                if (parsed == null) {
                                  return 'Stok harus berupa angka bulat';
                                }
                                if (parsed < 0) {
                                  return 'Stok minimal 0';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Deskripsi',
                        hint: 'Tuliskan fitur, material, dan manfaat produk.',
                        maxLines: 4,
                        onChanged: (value) =>
                            setState(() => _description = value),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Deskripsi tidak boleh kosong';
                          }
                          if (value.trim().length < 10) {
                            return 'Deskripsi minimal 10 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      DropdownButtonFormField<String>(
                        initialValue: _category,
                        decoration: const InputDecoration(
                          labelText: 'Kategori Produk',
                        ),
                        items: _categories
                            .map(
                              (c) => DropdownMenuItem<String>(
                                value: c.value,
                                child: Text(c.label),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => _category = value);
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'URL Thumbnail',
                        hint: 'https://domain.com/images/produk.jpg',
                        keyboardType: TextInputType.url,
                        onChanged: (value) =>
                            setState(() => _thumbnail = value),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'URL thumbnail tidak boleh kosong';
                          }
                          if (!_isValidUrl(value.trim())) {
                            return 'URL thumbnail tidak valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Tandai sebagai Produk Unggulan'),
                        subtitle: const Text(
                          'Akan diberi highlight seperti pada dashboard Django.',
                        ),
                        value: _isFeatured,
                        onChanged: (value) =>
                            setState(() => _isFeatured = value),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          icon: _isSubmitting
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Icon(Icons.save_outlined),
                          label: Text(
                            _isSubmitting ? 'Menyimpan...' : 'Simpan Produk',
                          ),
                          onPressed: _isSubmitting
                              ? null
                              : () => _handleSubmit(request),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    required ValueChanged<String> onChanged,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label, hintText: hint),
      onChanged: onChanged,
      validator: validator,
    );
  }

  String _categoryLabel(String value) {
    return _categories
        .firstWhere(
          (element) => element.value == value,
          orElse: () => const _CategoryOption(value: '-', label: '-'),
        )
        .label;
  }

  Widget _dialogRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _GuideChip extends StatelessWidget {
  const _GuideChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.white.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.white.withOpacity(0.2)),
      ),
    );
  }
}

class _CategoryOption {
  const _CategoryOption({required this.value, required this.label});

  final String value;
  final String label;
}
