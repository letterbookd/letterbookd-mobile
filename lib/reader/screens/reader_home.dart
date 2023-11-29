import 'package:flutter/material.dart';

/// ini contoh
class ReaderHome extends StatelessWidget {
  const ReaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reader"),
      ),
      body: const Center(child: Text("Halaman Reader")),
    );
  }
}
