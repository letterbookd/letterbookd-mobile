import 'package:flutter/material.dart';
import 'package:letterbookd/reader/models/reader_books.dart';

class BookInfoCard extends StatelessWidget {
  final BookDisplayInfo bookInfo;

  const BookInfoCard({super.key, required this.bookInfo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: bookInfo.thumbnail.isNotEmpty
                  ? Image.network(
                      bookInfo.thumbnail,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                bookInfo.title,
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.visible,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
