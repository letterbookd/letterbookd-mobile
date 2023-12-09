import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/models/book.dart';
import 'package:letterbookd/catalog/screens/librarian_edit_book.dart';
import 'package:letterbookd/core/screens/librarian_homepage.dart';
import 'package:letterbookd/main.dart';
import 'dart:convert';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LibrarianDetailBookPage extends StatelessWidget {
  final Book book;

  const LibrarianDetailBookPage({Key? key, required this.book}) : super(key: key);

  _showAlertDialog(BuildContext context, CookieRequest request) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget deleteButton = TextButton(
      child: const Text("Delete"),
      onPressed:  () async {
        final response = await _deleteBook(request);
        if (response['status'] == 'success') {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(
            content: Text("Buku '${book.fields.title}' berhasil dihapus!"),
            ));
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              const LibrarianHomePage()), (Route<dynamic> route) => false);
        } else {
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content:
                    Text("Terdapat kesalahan, silakan coba lagi.")));
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("DELETE BOOK"),
      content: Text("Are you sure you want to delete '${book.fields.title}'"),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<Map<String, dynamic>> _deleteBook(
    CookieRequest request,
  ) async {
    final response = await request.postJson(
                      '${AppData().url}/catalog/delete-book-flutter/',
                      jsonEncode(<String, String>{
                          'id': book.pk.toString(),
                      }));
    
    return response;
  }

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();

    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onBackground,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
        actions: <Widget>[
          IconButton(
              style: style,
              tooltip: "Edit Book Data",
              icon: const Icon(Icons.edit),
              onPressed: () {
              Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                        return const EditBookPage();
                      }));
              }),
          IconButton(
              style: style,
              tooltip: "Delete Book",
              icon: const Icon(Icons.delete_forever),
              onPressed: () async {
                _showAlertDialog(context, request);
              }),
        ],
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
