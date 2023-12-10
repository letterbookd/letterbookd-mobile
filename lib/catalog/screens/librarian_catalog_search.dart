import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/screens/librarian_detail_book.dart';
import 'package:letterbookd/catalog/widgets/librarian_book_tile.dart';
import 'package:letterbookd/main.dart';
import 'package:http/http.dart' as http;
import 'package:letterbookd/catalog/models/book.dart';

class LibrarianCatalogSearchPage extends StatefulWidget {
  const LibrarianCatalogSearchPage({super.key});

  @override
  State<LibrarianCatalogSearchPage> createState() => _LibrarianCatalogSearchPageState();
}

class _LibrarianCatalogSearchPageState extends State<LibrarianCatalogSearchPage> {

  final TextEditingController _searched = TextEditingController();

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
            tooltip: "Refresh",
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
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
              )   
            ),
        ],)
      )
    );
  }
}