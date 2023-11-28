import 'package:flutter/material.dart';

/// ini contoh
class LibraryDisplay extends StatelessWidget {
  const LibraryDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Library"),
        ),
        body: const Text("Library!"));
  }
}
