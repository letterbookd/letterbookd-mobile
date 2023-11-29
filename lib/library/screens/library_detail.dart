import 'package:flutter/material.dart';
import 'package:letterbookd/library/models/librarybook.dart';

class LibraryBookDetailPage extends StatelessWidget {
  // TODO: final LibraryBook libBook;

  const LibraryBookDetailPage({super.key});

  // TODO: replace with const LibraryBookDetailPage({Key? key, required this.libBook}) : super(key: key);

  void _toggleFavorite(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Favorited!'),
      ),
    );
  }

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
              tooltip: "Favorite",
              icon: const Icon(Icons.star),
              onPressed: () {
                _toggleFavorite(context);
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
            Container(
                margin: const EdgeInsets.only(bottom: 16.00),
                height: 180,
                child: Row(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 181 / 291,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: const Hero(
                          tag: "libbok-cover",
                          child: Image(
                            image: NetworkImage(
                                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Book Title", // TODO: repalce with libBook.fields.title
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Text(
                                    "Author(s)", // TODO: repalce with libBook.fields.authors
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                  ),
                                  Text(
                                    "1999 • 5.0", // TODO: repalce with libBook.fields.authors
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                  ),
                                ])))
                  ],
                )),

            // ACTIONS: Open in catalog, See reviews

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
