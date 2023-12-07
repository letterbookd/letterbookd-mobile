import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/models/book.dart';
import 'package:letterbookd/catalog/screens/detail_book.dart';
import 'package:letterbookd/catalog/widgets/book_card.dart';
import 'package:letterbookd/catalog/widgets/book_tile.dart';
import 'package:letterbookd/catalog/widgets/sort_modal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class CatalogHome extends StatefulWidget {
  const CatalogHome({Key? key}) : super(key: key);

  @override
  State<CatalogHome> createState() => _CatalogHomeState();
}

class _CatalogHomeState extends State<CatalogHome> {

  // ignore: prefer_final_fields
  ViewType _viewType = ViewType.tile;
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
      }
      else if (value == 'authors') {
        _sortBy = SortBy.authors;
      }
      else if (value == 'rating') {
        _sortBy = SortBy.rating;
      }
      else if (value == 'favoritesCount') {
        _sortBy = SortBy.favoritesCount;
      }

      fetchBook().then((_) {
        setState(() {}); // Trigger rebuild after fetching books
      });
    });
  }

  Future<List<Book>> fetchBook() async {
    
    var url = Uri.parse(
        'https://letterbookd-a09-tk.pbp.cs.ui.ac.id/catalog/json/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Book> books = [];
    for (var d in data) {
      if (d != null) {
          books.add(Book.fromJson(d));
      }
    }

    if (_sortBy == SortBy.title){
      books.sort((a, b) => a.fields.title.compareTo(b.fields.title));
    }
    else if (_sortBy == SortBy.authors){
      books.sort((a, b) => a.fields.authors.compareTo(b.fields.authors));
    }
    else if (_sortBy == SortBy.rating){
      books.sort((a, b) => b.fields.overallRating.compareTo(a.fields.overallRating));
    }
    else if (_sortBy == SortBy.favoritesCount){
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
          )),
        actions: <Widget>[
          IconButton(
            style: style,
            tooltip: "Sort By",
            icon: const Icon(Icons.sort_by_alpha_outlined),
            onPressed: () {
              _openSortModal(context);
          }),
          IconButton(
            style: style,
            tooltip: "View Type",
            icon: Icon(_viewType == ViewType.tile ? Icons.grid_view_sharp : Icons.view_list),
            onPressed: () {
              setState(() {
                if (_viewType == ViewType.tile) {
                  _viewType = ViewType.grid;
                } else {
                  _viewType = ViewType.tile;
                }
              });
            }
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

              // build tile view
              if (_viewType == ViewType.tile) {
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailBookPage(
                            book: snapshot.data![index]);
                      }));
                    },
                    child: BookTile(book: snapshot.data![index]),
                  )
                );
              } 
              
              // build grid view
              else {
                return GridView.builder(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 181 / 385,
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailBookPage(
                            book: snapshot.data![index]);
                      }));
                    },
                    child: BookCard(book: snapshot.data![index]),
                  )    
                );
              }
            }
          }
        }
      )
    );
  }
}
