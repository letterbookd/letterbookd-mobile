// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
//import 'package:letterbookd/forum/screens/forum_detail.dart';

class ThreadBox extends StatelessWidget {
  final String title;
  final String content;

  const ThreadBox({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(content),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.favorite),
                  label: const Text('Like'),
                ),
                TextButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.reply),
                  label: const Text('Reply'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
