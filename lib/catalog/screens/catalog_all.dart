import 'package:flutter/material.dart';

/// ini contoh
class CatalogHomepage extends StatelessWidget {
  const CatalogHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Catalog"),
        ),
        body: const Text("Catalog!"));
  }
}
