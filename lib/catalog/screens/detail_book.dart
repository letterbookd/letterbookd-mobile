import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/models/book.dart';
import 'package:letterbookd/main.dart';

// TODO: nanti ganti jadi book.fields.[data]

class DetailBookPage extends StatelessWidget {
  final Book book;

  const DetailBookPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
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
                  child: Image.network(book.thumbnail, fit: BoxFit.fitHeight),
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
                        book.title,
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        'by ${book.authors.split(';').map((author) => author).join(', ')}',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        '${book.published_year}',
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
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
                      const SizedBox(height: 5.0),
                      Text(
                        'Favorited by ${book.favorites_count} reader(s)',
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
              book.description,
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
              '${book.isbn13}',
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
              book.categories,
              style: const TextStyle(fontSize: 15.0,),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Page Count",
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold,),
            ),
            const SizedBox(height: 7.0),
            Text(
              '${book.page_count}',
              style: const TextStyle(fontSize: 15.0,),
            ),
          ],
        ),
      ),
    );
  }
}
