import 'package:flutter/material.dart';

/// ini contoh
class ForumHomepage extends StatelessWidget {
  const ForumHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Forum"),
        ),
        body: const Text("Forum!"));
  }
}
