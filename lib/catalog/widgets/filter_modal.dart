import 'package:flutter/material.dart';

class BookFilterModal extends StatefulWidget {
  const BookFilterModal({super.key});

  @override
  State<BookFilterModal> createState() => _BookFilterModalState();
}

class _BookFilterModalState extends State<BookFilterModal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Center(
          child: Text(
            'Filter Catalog',
            style: TextStyle(fontSize: 18.0,),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.align_horizontal_left_sharp),
          title: const Text('All'),
          onTap: () {
            Navigator.pop(context, 'all');
          },
        ),
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text("In user's library"),
          onTap: () {
            Navigator.pop(context, 'library');
          },
        ),
      ],
    );
  }
}
