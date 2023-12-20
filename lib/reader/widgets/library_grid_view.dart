import 'package:flutter/material.dart';
import 'package:letterbookd/reader/models/reader_books.dart';
import 'package:letterbookd/reader/widgets/book_info_card.dart';

class LibraryGridView extends StatelessWidget {
  final List<BookDisplayInfo> books;

  const LibraryGridView({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Your Library",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.6,
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            return BookInfoCard(bookInfo: books[index]);
          },
        ),
      ],
    );
  }
}
