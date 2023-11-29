import 'package:flutter/material.dart';

class LibraryTile extends StatelessWidget {
  const LibraryTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          /// TODO: replace with proper book cover
          Image.network(
            "http://books.google.com/books/content?id=m9cZAAAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
            scale: 1.0,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withAlpha(0),
                  Colors.black12,
                  Colors.black45
                ],
              ),
            ),

            /// TODO: replace with proper book title
            child: const Text("book_title"),
          ),
        ],
      ),
    );
  }
}
