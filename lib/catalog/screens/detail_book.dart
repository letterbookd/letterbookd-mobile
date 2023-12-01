import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/models/book.dart';
import 'package:letterbookd/main.dart';

// nanti ganti jadi book.fields.[data]

class DetailBookPage extends StatelessWidget {
  final Book book;

  const DetailBookPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
      ),
      // drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: SizedBox(
              width: 200,
              child: AspectRatio(
                aspectRatio: AppData().bookAspectRatio,
                child: Image.network(book.thumbnail, fit: BoxFit.fitWidth),
              ),
            )),
            const SizedBox(height: 30.0),
            Text(
              book.title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'ISBN: ${book.isbn13}',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 15.0),
            Text(
              'Authors: ${book.authors.split(';').map((author) => author).join(', ')}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 15.0),
            Text(
              'Categories: ${book.categories}',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 15.0),
            Text(
              'Publised year: ${book.published_year}',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 15.0),
            Text(
              'Page count: ${book.page_count}',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 15.0),
            Text(
              'Overall rating: ${book.overall_rating}',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 15.0),
            Text(
              'Favorites count: ${book.favorites_count}',
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 15.0),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              book.description,
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
