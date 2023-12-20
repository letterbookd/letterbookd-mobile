import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/models/book.dart';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;

class LibrarianBookTile extends StatelessWidget {
  final Book book;

  const LibrarianBookTile({super.key, required this.book}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: app_data.bookAspectRatio,
                child:
                    Image.network(book.fields.thumbnail, fit: BoxFit.fitHeight),
              ),
            ),
          ),
          Flexible(
              child: Container(
            padding: const EdgeInsets.only(left: 22, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ISBN: ${book.fields.isbn13}',
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Title: ${book.fields.title}',
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Authors: ${book.fields.authors.split(';').map((author) => author).join(', ')}",
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Overall rating: ${book.fields.overallRating}',
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ))
        ],
      ),
    ));
  }
}
