import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _description = '';
  String _category = 'apparel';
  String _thumbnail = '';
  bool _isFeatured = false;
  String _priceRaw = '';

  final List<String> _categories = <String>[
    'apparel',
    'boots',
    'equipment',
    'accessories',
  ];

  double? get _price => double.tryParse(_priceRaw);

  bool _isValidUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null && uri.hasScheme && uri.hasAuthority;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk Baru'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nama Produk',
                    hintText: 'Contoh: Jersey Home 24/25',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => _name = value),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    if (value.trim().length < 3) {
                      return 'Nama minimal 3 karakter';
                    }
                    if (value.trim().length > 80) {
                      return 'Nama maksimal 80 karakter';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Harga',
                    hintText: 'Contoh: 299000',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => _priceRaw = value),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Harga tidak boleh kosong';
                    }
                    final parsed = double.tryParse(value);
                    if (parsed == null) {
                      return 'Harga harus berupa angka';
                    }
                    if (parsed <= 0) {
                      return 'Harga harus lebih dari 0';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi',
                    hintText: 'Tuliskan detail produk',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => _description = value),
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  value: _category,
                  decoration: InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  items: _categories
                      .map((c) => DropdownMenuItem<String>(
                            value: c,
                            child: Text(c[0].toUpperCase() + c.substring(1)),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _category = value ?? _category),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'URL Thumbnail',
                    hintText: 'https://contoh.com/gambar.jpg',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => _thumbnail = value),
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
              ),
              SwitchListTile(
                title: const Text('Tandai sebagai Produk Unggulan'),
                value: _isFeatured,
                onChanged: (v) => setState(() => _isFeatured = v),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Produk berhasil disimpan'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nama: \t$_name'),
                                  Text('Harga: \t${_price?.toStringAsFixed(2)}'),
                                  Text('Deskripsi: \t$_description'),
                                  Text('Kategori: \t$_category'),
                                  Text('Thumbnail: \t$_thumbnail'),
                                  Text('Unggulan: \t${_isFeatured ? 'Ya' : 'Tidak'}'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _formKey.currentState!.reset();
                                  setState(() {
                                    _name = '';
                                    _description = '';
                                    _category = 'apparel';
                                    _thumbnail = '';
                                    _isFeatured = false;
                                    _priceRaw = '';
                                  });
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

