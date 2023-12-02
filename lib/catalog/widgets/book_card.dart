import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/models/book.dart';
import 'package:letterbookd/main.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({Key? key, required this.book}) : super(key: key); // Constructor

  // const BookTile(this.book, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        child: Column(children: [
          SizedBox(
            height: 180,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: AppData().bookAspectRatio,
                child: Image.network(book.thumbnail, fit: BoxFit.fitHeight),
              ),
            )
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 7),
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
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
                  ),

                  const SizedBox(height: 4),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "by ${book.authors.split(';').map((author) => author).join(', ')}",
                      style: const TextStyle(
                          fontSize: 12.0,
                      ),  
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      textAlign: TextAlign.left,
                    ),
                  ),
              ],
            ),
          )
        ],
        ),
      )
    );
  }
}