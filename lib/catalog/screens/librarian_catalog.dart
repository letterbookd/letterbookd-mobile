import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/models/book.dart';
import 'package:letterbookd/catalog/screens/librarian_detail_book.dart';
import 'package:letterbookd/catalog/widgets/librarian_book_tile.dart';
import 'package:letterbookd/catalog/widgets/sort_modal.dart';
import 'package:letterbookd/catalog/screens/librarian_add_book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:letterbookd/main.dart';

// declare view types
enum ViewType {
  tile,
  grid,
}

// declare sort by
enum SortBy {
  title,
  authors,
  rating,
  favoritesCount,
}

class LibrarianCatalog extends StatefulWidget {
  const LibrarianCatalog({Key? key}) : super(key: key);

  @override
  State<LibrarianCatalog> createState() => _LibrarianCatalogState();
}

class _LibrarianCatalogState extends State<LibrarianCatalog> {
  // ignore: prefer_final_fields
  SortBy _sortBy = SortBy.title;

  // method for opening sort modal
  void _openSortModal(BuildContext context) {
    showModalBottomSheet(
      useRootNavigator: true,
      showDragHandle: true,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return const BookSortModal();
      },
    ).then((value) {
      if (value == 'title') {
        _sortBy = SortBy.title;
      } else if (value == 'authors') {
        _sortBy = SortBy.authors;
      } else if (value == 'rating') {
        _sortBy = SortBy.rating;
      } else if (value == 'favoritesCount') {
        _sortBy = SortBy.favoritesCount;
      }

      fetchBook().then((_) {
        setState(() {}); // Trigger rebuild after fetching books
      });
    });
  }


  Future<List<Book>> fetchBook() async {
    var url = Uri.parse('${AppData().url}/catalog/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Book
    List<Book> books = [];
    for (var d in data) {
      if (d != null) {
        books.add(Book.fromJson(d));
      }
    }

    if (_sortBy == SortBy.title) {
      books.sort((a, b) => a.fields.title.compareTo(b.fields.title));
    } else if (_sortBy == SortBy.authors) {
      books.sort((a, b) => a.fields.authors.compareTo(b.fields.authors));
    } else if (_sortBy == SortBy.rating) {
      books.sort((a, b) => b.fields.overallRating.compareTo(a.fields.overallRating));
    } else if (_sortBy == SortBy.favoritesCount) {
      books.sort((a, b) => b.fields.favoritesCount.compareTo(a.fields.favoritesCount));
    }

    return books;
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onBackground,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Divider(
            height: 1,
            indent: 10,
            endIndent: 10,
          )
        ),
        actions: <Widget>[
          IconButton(
            style: style,
            tooltip: "Add book",
            icon: const Icon(Icons.add),
            onPressed: () {
            Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                      return const AddBookPage();
                    }));
            }
          ),
          IconButton(
            style: style,
            tooltip: "Sort By",
            icon: const Icon(Icons.sort_by_alpha_outlined),
            onPressed: () {
              _openSortModal(context);
            }
          ),
          IconButton(
            style: style,
            tooltip: "Refresh",
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: fetchBook(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Tidak ada data buku.",
                    style:
                        TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LibrarianDetailBookPage(
                          book: snapshot.data![index]);
                    }));
                  },
                  child: LibrarianBookTile(book: snapshot.data![index]),
                )
              );
            }
          }
        }
      )
    );
  }
}
