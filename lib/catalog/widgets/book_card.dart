import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/models/book.dart';
import 'package:letterbookd/main.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({Key? key, required this.book}) : super(key: key); // Constructor

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: AppData().bookAspectRatio,
              child: Image.network(book.thumbnail, fit: BoxFit.fitHeight)
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 7),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.star),
                    Text(
                      '${book.overall_rating}',
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  book.title,
                  style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.left,
                ),
                // Text(
                //   "by ${book.authors.split(';').map((author) => author).join(', ')}",
                //   style: const TextStyle(
                //       fontSize: 12.0,
                //   ),  
                //   overflow: TextOverflow.ellipsis,
                //   maxLines: 1,
                //   softWrap: true,
                //   textAlign: TextAlign.left,
                // ),
              ],
            ),
          )
        ],
        ),
      )
    );
  }
}