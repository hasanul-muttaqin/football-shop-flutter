import 'package:flutter/material.dart';
import 'package:football_shop/screens/home.dart';
import 'package:football_shop/screens/product_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Football Shop',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Belanja perlengkapan sepak bola favoritmu!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box_outlined),
            title: const Text('Tambah Produk'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductFormPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

