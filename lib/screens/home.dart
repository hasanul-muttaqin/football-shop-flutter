import 'package:flutter/material.dart';
import 'package:football_shop/screens/product_form.dart';
import 'package:football_shop/widgets/left_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football Shop'),
      ),
      drawer: const LeftDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => _showSnackBar(
                    context,
                    'Kamu telah menekan tombol All Products',
                  ),
                  icon: const Icon(Icons.list_alt),
                  label: const Text('All Products'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => _showSnackBar(
                    context,
                    'Kamu telah menekan tombol My Products',
                  ),
                  icon: const Icon(Icons.shopping_bag),
                  label: const Text('My Products'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProductFormPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_box),
                  label: const Text('Tambah Produk'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

