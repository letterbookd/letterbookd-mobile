import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/models/book.dart';
import 'package:letterbookd/catalog/screens/detail_book.dart';
import 'dart:ffi';

/// ini contoh
// class CatalogHome extends StatelessWidget {
//   const CatalogHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Catalog"),
//       ),
//       body: const Center(child: Text("Halaman utama Catalog")),
//     );
//   }
// }

class CatalogHome extends StatefulWidget {

  const CatalogHome({Key? key}) : super(key: key);

  @override
  _CatalogHomeState createState() => _CatalogHomeState();
}

class _CatalogHomeState extends State<CatalogHome> {
Future<List<Book>> fetchBook() async {

    // sementara dulu, karena belum integrasi sm django
    List<Book> books = [
    Book(9780002005883, "Gilead", "Marilynne Robinson", "Fiction", "http://books.google.com/books/content?id=KQZCPgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api", "ini adalah buku ya hahaha", 2004, 247, 0, 0),
    Book(9780002261982, "Spider's Web", "Charles Osborne;Agatha Christie", "Detective and mystery stories", "http://books.google.com/books/content?id=gA5GPgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api", "ini adalah buku yang hihihi", 2000, 241, 0, 0),
    Book(9780006163831, "The One Tree", "Stephen R. Donaldson", "American fiction", "http://books.google.com/books/content?id=OmQawwEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api", "ini adalah buku yang hehehe", 1982, 479, 0, 0),
    Book(9780006178736, "Rage of angels", "Sidney Sheldon", "Fiction", "http://books.google.com/books/content?id=FKo2TgANz74C&printsec=frontcover&img=1&zoom=1&source=gbs_api", "ini adalah buku yang hohoho", 1993, 512, 0, 0),
    Book(9780006280897, "The Four Loves", "Clive Staples Lewis", "Christian life", "http://books.google.com/books/content?id=XhQ5XsFcpGIC&printsec=frontcover&img=1&zoom=1&source=gbs_api", "ini adalah buku yang hwehhheheheh", 2002, 170, 0, 0),
    ];
    
    return books;
}

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Catalog'),
        ),
        // drawer: const LeftDrawer(),
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
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DetailBookPage(
                                  book: snapshot.data![index]);
                            }));
                          },
                          child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Container(
                                      width: 70,
                                      child: Image.network(snapshot.data![index].thumbnail, fit: BoxFit.fitWidth),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                    "${snapshot.data![index].title}",
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text("${snapshot.data![index].authors.split(';').map((author) => "$author").join(', ')}"),
                                ],
                                ),
                            )
                          )    
                        );
                    }
                }
            }));
    }
}
