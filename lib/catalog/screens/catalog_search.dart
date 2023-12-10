import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/widgets/book_card.dart';
import 'package:letterbookd/catalog/widgets/book_tile.dart';
import 'package:letterbookd/main.dart';
import 'package:http/http.dart' as http;
import 'package:letterbookd/catalog/models/book.dart';
import 'package:letterbookd/catalog/screens/detail_book.dart';

// declare view types
enum ViewType {
  tile,
  grid,
}

class CatalogSearchPage extends StatefulWidget {
  const CatalogSearchPage({super.key});

  @override
  State<CatalogSearchPage> createState() => _CatalogSearchPageState();
}

class _CatalogSearchPageState extends State<CatalogSearchPage> {

  // ignore: prefer_final_fields
  ViewType _viewType = ViewType.tile;

  final TextEditingController _searched = TextEditingController();

  // declare the list of to-be-displayed books
  // List<Book> books = [];
  
  // void updateList(String value){

  //   fetchBook();

  //   setState(() {
  //     books = books.where((element) => element.fields.title.toLowerCase().contains(value.toLowerCase())).toList();
  //   });
  // }

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

    books = books.where((element) => 
      element.fields.title.toLowerCase().contains(_searched.text.toLowerCase()) ||
      element.fields.authors.toLowerCase().contains(_searched.text.toLowerCase())
      ).toList();

    return books;
  }


  @override
  Widget build(BuildContext context){

    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onBackground,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog Search'),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Search book by title or authors",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              // textInputAction: TextInputAction.search,
              controller: _searched,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                filled: true,
                hintText: "Search...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),

            Expanded(
              child: FutureBuilder(
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
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
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
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 181 / 400,
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
            ),
        ],)
      )
    );
  }
}