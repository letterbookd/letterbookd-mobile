import 'package:flutter/material.dart';

/// ini contoh
class CatalogHome extends StatelessWidget {
  const CatalogHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catalog"),
      ),
      body: const Center(child: Text("Halaman utama Catalog")),
    );
  }
}
