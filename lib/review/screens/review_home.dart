import 'package:flutter/material.dart';

/// ini contoh
class ReviewHomepage extends StatelessWidget {
  const ReviewHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Reviews"),
        ),
        body: const Text("Reviews!"));
  }
}
