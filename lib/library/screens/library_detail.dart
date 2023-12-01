import 'package:flutter/material.dart';
import 'package:letterbookd/library/models/librarybook.dart';
import 'package:letterbookd/library/widgets/library_detail_actions.dart';
import 'package:letterbookd/library/widgets/library_detail_header.dart';

class LibraryBookDetailPage extends StatelessWidget {
  // TODO: final LibraryBook libBook;

  const LibraryBookDetailPage({super.key});

  // TODO: replace with const LibraryBookDetailPage({Key? key, required this.libBook}) : super(key: key);

  void _editStatus(BuildContext context) {}

  void _deleteFromLibrary(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Removing from library'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onBackground,
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              style: style,
              tooltip: "Change Status",
              icon: const Icon(Icons.edit),
              onPressed: () {
                _editStatus(context);
              }),
          IconButton(
              tooltip: "Remove",
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteFromLibrary(context);
              }),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // HEADER: cover, title, author(s), year, rating, tracking status
            const LibraryDetailHeader(),

            // ACTIONS: Open in catalog, See reviews
            const LibraryDetailActions(),

            // BODY: description
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua', // TODO: replace with libBook.fields.amount
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
