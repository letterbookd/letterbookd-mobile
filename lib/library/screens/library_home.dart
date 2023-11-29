import 'package:flutter/material.dart';

/// ini contoh
class LibraryHome extends StatelessWidget {
  const LibraryHome({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onBackground,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Library"),
        actions: <Widget>[
          IconButton(
            style: style,
            tooltip: "Filter",
            onPressed: () {},
            icon: const Icon(Icons.filter_list_rounded),
          ),
          IconButton(
            style: style,
            tooltip: "Refresh",
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: const Center(child: Text("Halaman utama Library")),
      // TODO: add elevated button to add new
    );
  }
}
