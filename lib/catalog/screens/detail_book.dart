import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/models/book.dart';
import 'package:letterbookd/main.dart';

class DetailBookPage extends StatelessWidget {
  final Book book;

  const DetailBookPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: <Widget>[
              SizedBox(
              width: 130,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: AppData().bookAspectRatio,
                  child: Image.network(book.fields.thumbnail, fit: BoxFit.fitHeight),
                  ),
                )
              ),

              Flexible(child:
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.fields.title,
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        'by ${book.fields.authors.split(';').map((author) => author).join(', ')}',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        '${book.fields.publishedYear}',
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          const Icon(Icons.star),
                          Text(
                            '${book.fields.overallRating}',
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        'Favorited by ${book.fields.favoritesCount} reader(s)',
                        style: const TextStyle(fontSize: 14.0,),
                      ),
                      const SizedBox(height: 10.0),
                      SizedBox(
                        width: 130,
                        height: 38,
                        child: TextButton(
                          onPressed: () {
                            //TODO: add function
                          },
                          style: TextButton.styleFrom(
                            side: const BorderSide(width: 1),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.reviews_outlined,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text("See reviews"),
                            ],
                          )
                        ),
                      ),
                    ],
                  )
                )
              ),
            ],),

            const SizedBox(height: 20.0),
            const Text(
              "Description",
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold,),
            ),
            const SizedBox(height: 7.0),
            Text(
              book.fields.description,
              style: const TextStyle(fontSize: 15.0),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20.0),
            const Text(
              "ISBN",
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold,),
            ),
            const SizedBox(height: 7.0),
            Text(
              '${book.fields.isbn13}',
              style: const TextStyle(
                fontSize: 15.0,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Categories",
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold,),
            ),
            const SizedBox(height: 7.0),
            Text(
              book.fields.categories,
              style: const TextStyle(fontSize: 15.0,),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Page Count",
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold,),
            ),
            const SizedBox(height: 7.0),
            Text(
              '${book.fields.pageCount}',
              style: const TextStyle(fontSize: 15.0,),
            ),
          ],
        ),
      ),
    );
  }
}
