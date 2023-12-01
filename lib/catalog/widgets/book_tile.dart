import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/models/book.dart';

class BookTile extends StatelessWidget {
  final Book book;

  const BookTile({Key? key, required this.book}) : super(key: key); // Constructor

  // const BookTile(this.book, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        padding: const EdgeInsets.all(15.0),
        child: Row(children: [
          Container(
            width: 70,
            child: Image.network(book.thumbnail, fit: BoxFit.fitWidth),
          ),

          Flexible(
            child: Container(
                padding: const EdgeInsets.only(left: 22, right:15),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                    "${book.title}",
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                    ),
                    ),
                    const SizedBox(height: 10),
                    Text("by ${book.authors.split(';').map((author) => "$author").join(', ')}"),
                    const SizedBox(height: 10),
                    Text("${book.categories}"),
                ],
                ),
            )
          )
        ],
        ),
      )
    );
  }
}