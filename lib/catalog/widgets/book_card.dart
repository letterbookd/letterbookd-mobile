import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/models/book.dart';
import 'package:letterbookd/main.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({Key? key, required this.book}) : super(key: key); // Constructor

  // const BookTile(this.book, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Column(children: [
          SizedBox(
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: AppData().bookAspectRatio,
                child: Image.network(book.thumbnail, fit: BoxFit.fitHeight),
              ),
            )
          ),
          Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                    const SizedBox(height: 10),
                    Text(
                      book.title,
                      style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "by ${book.authors.split(';').map((author) => author).join(', ')}",
                      overflow: TextOverflow.ellipsis,),
                ],
              ),
            )
        ],
        ),
      )
    );
  }
}