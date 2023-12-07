import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/models/book.dart';
import 'package:letterbookd/catalog/screens/detail_book.dart';
import 'package:letterbookd/catalog/widgets/book_card.dart';
import 'package:letterbookd/catalog/widgets/book_tile.dart';
import 'package:letterbookd/catalog/widgets/sort_modal.dart';

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
          4.23,
          70),
      Book(
          9780002261982,
          "Spider's Web",
          "Charles Osborne;Agatha Christie",
          "Detective and mystery stories",
          "http://books.google.com/books/content?id=gA5GPgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
          "Lorem ipsum dolor sit amet. Sit tenetur vero ad expedita eaque ut maiores aperiam At architecto doloremque est tenetur eveniet. Vel vitae voluptatem et ipsa perferendis At odit voluptas ut reiciendis consequuntur.",
          2000,
          241,
          3.3,
          2),
      Book(
          9780006163831,
          "The One Tree",
          "Stephen R. Donaldson",
          "American fiction",
          "http://books.google.com/books/content?id=OmQawwEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
          "Lorem ipsum dolor sit amet. Sit tenetur vero ad expedita eaque ut maiores aperiam At architecto doloremque est tenetur eveniet. Vel vitae voluptatem et ipsa perferendis At odit voluptas ut reiciendis consequuntur.",
          1982,
          479,
          4.78,
          50),
      Book(
          9780006490456, 
          "Witness for the Prosecution & Selected Plays", 
          "Agatha Christie", "English drama", 
          "http://books.google.com/books/content?id=_9u7AAAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api", 
          "Lorem ipsum dolor sit amet. Sit tenetur vero ad expedita eaque ut maiores aperiam At architecto doloremque est tenetur eveniet. Vel vitae voluptatem et ipsa perferendis At odit voluptas ut reiciendis consequuntur.", 
          1995, 
          352, 
          0.0, 
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
          0.0,
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
          0.0,
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
          4.3,
          25),
      Book(
          9780006353287,
          "An Autobiography",
          "Agatha Christie",
          "Authors, English",
          "http://books.google.com/books/content?id=c49GQwAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
          "Lorem ipsum dolor sit amet. Sit tenetur vero ad expedita eaque ut maiores aperiam At architecto doloremque est tenetur eveniet. Vel vitae voluptatem et ipsa perferendis At odit voluptas ut reiciendis consequuntur.",
          1977,
          560,
          0.0,
          0),
    ];

    if (_sortBy == SortBy.title){
      books.sort((a, b) => a.title.compareTo(b.title));
    }
    else if (_sortBy == SortBy.authors){
      books.sort((a, b) => a.authors.compareTo(b.authors));
    }
    else if (_sortBy == SortBy.rating){
      books.sort((a, b) => b.overall_rating.compareTo(a.overall_rating));
    }
    else if (_sortBy == SortBy.favoritesCount){
      books.sort((a, b) => b.favorites_count.compareTo(a.favorites_count));
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
                }),
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
            }));
  }
}
