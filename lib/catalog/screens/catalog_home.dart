import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/models/book.dart';
import 'package:letterbookd/catalog/screens/detail_book.dart';
import 'package:letterbookd/catalog/widgets/book_card.dart';
import 'package:letterbookd/catalog/widgets/book_tile.dart';

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
  State<CatalogHome> createState() => _CatalogHomeState();
}

class _CatalogHomeState extends State<CatalogHome> {
  Future<List<Book>> fetchBook() async {
    // sementara dulu, karena belum integrasi dgn django
    List<Book> books = [
      Book(
          9780002005883,
          "Gilead",
          "Marilynne Robinson",
          "Fiction",
          "http://books.google.com/books/content?id=KQZCPgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
          "Lorem ipsum dolor sit amet. Sit tenetur vero ad expedita eaque ut maiores aperiam At architecto doloremque est tenetur eveniet. Vel vitae voluptatem et ipsa perferendis At odit voluptas ut reiciendis consequuntur.",
          2004,
          247,
          0,
          0),
      Book(
          9780002261982,
          "Spider's Web",
          "Charles Osborne;Agatha Christie",
          "Detective and mystery stories",
          "http://books.google.com/books/content?id=gA5GPgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
          "Lorem ipsum dolor sit amet. Sit tenetur vero ad expedita eaque ut maiores aperiam At architecto doloremque est tenetur eveniet. Vel vitae voluptatem et ipsa perferendis At odit voluptas ut reiciendis consequuntur.",
          2000,
          241,
          0,
          0),
      Book(
          9780006163831,
          "The One Tree",
          "Stephen R. Donaldson",
          "American fiction",
          "http://books.google.com/books/content?id=OmQawwEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
          "Lorem ipsum dolor sit amet. Sit tenetur vero ad expedita eaque ut maiores aperiam At architecto doloremque est tenetur eveniet. Vel vitae voluptatem et ipsa perferendis At odit voluptas ut reiciendis consequuntur.",
          1982,
          479,
          0,
          0),
      Book(
          9780006490456, 
          "Witness for the Prosecution & Selected Plays", 
          "Agatha Christie", "English drama", 
          "http://books.google.com/books/content?id=_9u7AAAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api", 
          "Lorem ipsum dolor sit amet. Sit tenetur vero ad expedita eaque ut maiores aperiam At architecto doloremque est tenetur eveniet. Vel vitae voluptatem et ipsa perferendis At odit voluptas ut reiciendis consequuntur.", 
          1995, 
          352, 
          0, 
          0),
      Book(
          9780006178736,
          "Rage of angels",
          "Sidney Sheldon",
          "Fiction",
          "http://books.google.com/books/content?id=FKo2TgANz74C&printsec=frontcover&img=1&zoom=1&source=gbs_api",
          "Lorem ipsum dolor sit amet. Sit tenetur vero ad expedita eaque ut maiores aperiam At architecto doloremque est tenetur eveniet. Vel vitae voluptatem et ipsa perferendis At odit voluptas ut reiciendis consequuntur.",
          1993,
          512,
          0,
          0),
      Book(
          9780006280897,
          "The Four Loves",
          "Clive Staples Lewis",
          "Christian life",
          "http://books.google.com/books/content?id=XhQ5XsFcpGIC&printsec=frontcover&img=1&zoom=1&source=gbs_api",
          "Lorem ipsum dolor sit amet. Sit tenetur vero ad expedita eaque ut maiores aperiam At architecto doloremque est tenetur eveniet. Vel vitae voluptatem et ipsa perferendis At odit voluptas ut reiciendis consequuntur.",
          2002,
          170,
          0,
          0),
      Book(
          9780006280934,
          "The Problem of Pain",
          "Clive Staples Lewis",
          "Christian life",
          "http://books.google.com/books/content?id=Kk-uVe5QK-gC&printsec=frontcover&img=1&zoom=1&source=gbs_api",
          "Lorem ipsum dolor sit amet. Sit tenetur vero ad expedita eaque ut maiores aperiam At architecto doloremque est tenetur eveniet. Vel vitae voluptatem et ipsa perferendis At odit voluptas ut reiciendis consequuntur.",
          2002,
          176,
          0,
          0),
      Book(
          9780006353287,
          "An Autobiography",
          "Agatha Christie",
          "Authors, English",
          "http://books.google.com/books/content?id=c49GQwAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
          "Lorem ipsum dolor sit amet. Sit tenetur vero ad expedita eaque ut maiores aperiam At architecto doloremque est tenetur eveniet. Vel vitae voluptatem et ipsa perferendis At odit voluptas ut reiciendis consequuntur.",
          1977,
          560,
          0,
          0),
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
                    return GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: ((MediaQuery.of(context).size.width / 2) / (MediaQuery.of(context).size.height / 3.5)),
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 30.0,
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

                    // return ListView.builder(
                    //     itemCount: snapshot.data!.length,
                    //     itemBuilder: (_, index) => InkWell(
                    //       onTap: () {
                    //         Navigator.push(context,
                    //             MaterialPageRoute(builder: (context) {
                    //           return DetailBookPage(
                    //               book: snapshot.data![index]);
                    //         }));
                    //       },
                    //       child: BookTile(book: snapshot.data![index]),
                    //       )    
                    //     );
                    // }
                }
            }));
  }
}
