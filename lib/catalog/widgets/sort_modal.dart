import 'package:flutter/material.dart';

class BookSortModal extends StatefulWidget {
  const BookSortModal({super.key});

  @override
  State<BookSortModal> createState() => _BookSortModalState();
}

class _BookSortModalState extends State<BookSortModal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Center(
          child: Text(
            'Sort Catalog by',
            style: TextStyle(fontSize: 18.0,),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.title),
          title: const Text('Title'),
          onTap: () {
            Navigator.pop(context, 'title');
          },
        ),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Authors'),
          onTap: () {
            Navigator.pop(context, 'authors');
          },
        ),
        ListTile(
          leading: const Icon(Icons.star),
          title: const Text('Rating'),
          onTap: () {
            Navigator.pop(context, 'rating');
          },
        ),
        ListTile(
          leading: const Icon(Icons.thumb_up_sharp),
          title: const Text('Favorites count'),
          onTap: () {
            Navigator.pop(context, 'favoritesCount');
          },
        ),
      ],
    );
  }
}
