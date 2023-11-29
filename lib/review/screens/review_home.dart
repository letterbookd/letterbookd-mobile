import 'package:flutter/material.dart';

/// ini contoh
class ReviewHome extends StatelessWidget {
  const ReviewHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
      ),
      body: const Center(child: Text("Halaman utama Reviews")),
    );
  }
}
