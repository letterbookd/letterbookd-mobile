import 'package:flutter/material.dart';

/// ini contoh
class ForumHome extends StatelessWidget {
  const ForumHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forum"),
      ),
      body: const Center(child: Text("Halaman utama Forum")),
    );
  }
}
