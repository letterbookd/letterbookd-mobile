import 'package:flutter/material.dart';
import 'package:letterbookd/reader/models/reader.dart';

class SearchResultList extends StatelessWidget {
  final List<ReaderElement> readers;

  const SearchResultList({super.key, required this.readers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: readers.map((reader) {
        return Card(
          margin: const EdgeInsets.all(16.0),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/pfp_0.jpg'),
            ),
            title: Text(reader.displayName),
            subtitle: Text(reader.bio),
          ),
        );
      }).toList(),
    );
  }
}
