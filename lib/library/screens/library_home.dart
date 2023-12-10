import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/models/book.dart';
import 'package:letterbookd/library/models/library.dart';
import 'package:letterbookd/library/models/librarybook.dart';
import 'package:letterbookd/library/widgets/library_filter_modal.dart';
import 'package:letterbookd/library/widgets/library_tile.dart';
import 'package:http/http.dart' as http;
import 'package:letterbookd/main.dart';
import 'dart:convert';

// filter and sort types
enum DisplayType {
  tile,
  grid,
}

enum SortBy {
  title,
  recentlyAdded,
  trackingStatus,
}

enum SortDirection {
  ascending,
  descending,
}

enum FilterBy {
  all,
  favorites,
  finished,
  reading,
  onHold,
  planned,
  dropped,
  reviewed,
}

class LibraryData {
  final List<String> trackingStatusList = [
    "Untracked",
    "Finished Reading",
    "Currently Reading",
    "On Hold",
    "Planning to Read",
    "Dropped",
  ];
}

class LibraryItem {
  final LibraryBook libraryData;
  final Book bookData;

  const LibraryItem(this.libraryData, this.bookData);
}

class LibraryHome extends StatefulWidget {
  const LibraryHome({super.key});

  @override
  State<LibraryHome> createState() => _LibraryHomeState();
}

class _LibraryHomeState extends State<LibraryHome> {
  late List<LibraryItem> _cachedLibraryItems;
  late List<LibraryItem> _sortedLibraryItems;
  DisplayType _displayType = DisplayType.tile;
  SortBy _sortBy = SortBy.title;
  SortDirection _sortDirection = SortDirection.descending;
  FilterBy _filterBy = FilterBy.all;

  void _addBookForm(BuildContext context) {}

  void _openFilterModal(BuildContext context) {
    showModalBottomSheet<void>(
      useRootNavigator: true,
      showDragHandle: true,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return const LibraryFilterModal();
      },
    );
  }

  void _refreshLibrary(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Refreshing library'),
      ),
    );
  }

  /// Getting all libraryBook in user
  Future<List<LibraryItem>> fetchLibrary() async {
    var url = Uri.parse('${AppData().url}/library/get/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

    List<LibraryItem> libraryItem = [];
    for (var data in jsonResponse) {
      if (data != null) {
        libraryItem.add(LibraryItem(LibraryBook.fromJson(data["library_data"]),
            Book.fromJson(data["book_data"])));
      }
    }

    return libraryItem;
  }

  /// Apply sort and filter to library items
  List<LibraryItem> applySortAndFilters() {
    List<LibraryItem> sortedItems = List<LibraryItem>.from(_cachedLibraryItems);

    // sort items
    if (_sortBy == SortBy.title) {
      if (_sortDirection == SortDirection.descending) {
        sortedItems.sort((a, b) =>
            a.bookData.fields.title.compareTo(b.bookData.fields.title));
      } else {
        sortedItems.sort((a, b) =>
            b.bookData.fields.title.compareTo(a.bookData.fields.title));
      }
    } else if (_sortBy == SortBy.recentlyAdded) {
      if (_sortDirection == SortDirection.descending) {
        sortedItems
            .sort((a, b) => a.libraryData.pk.compareTo(b.libraryData.pk));
      } else {
        sortedItems
            .sort((a, b) => b.libraryData.pk.compareTo(a.libraryData.pk));
      }
    } else if (_sortBy == SortBy.trackingStatus) {
      if (_sortDirection == SortDirection.descending) {
        sortedItems.sort((a, b) => a.libraryData.fields.trackingStatus
            .compareTo(b.libraryData.fields.trackingStatus));
      } else {
        sortedItems.sort((a, b) => b.libraryData.fields.trackingStatus
            .compareTo(a.libraryData.fields.trackingStatus));
      }
    }

    // filter item
    if (_filterBy == FilterBy.favorites) {
      sortedItems = sortedItems
          .where((item) => item.libraryData.fields.isFavorited == true)
          .toList();
    } else if (_filterBy == FilterBy.finished) {
      sortedItems = sortedItems
          .where((item) => item.libraryData.fields.trackingStatus == 1)
          .toList();
    } else if (_filterBy == FilterBy.reading) {
      sortedItems = sortedItems
          .where((item) => item.libraryData.fields.trackingStatus == 2)
          .toList();
    } else if (_filterBy == FilterBy.planned) {
      sortedItems = sortedItems
          .where((item) => item.libraryData.fields.trackingStatus == 3)
          .toList();
    } else if (_filterBy == FilterBy.onHold) {
      sortedItems = sortedItems
          .where((item) => item.libraryData.fields.trackingStatus == 4)
          .toList();
    } else if (_filterBy == FilterBy.dropped) {
      sortedItems = sortedItems
          .where((item) => item.libraryData.fields.trackingStatus == 5)
          .toList();
    }

    return sortedItems;
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onBackground,
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text("Library"),
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
                tooltip: "Add book",
                icon: const Icon(Icons.add),
                onPressed: () {
                  _addBookForm(context);
                }),
            IconButton(
                style: style,
                tooltip: "Filter",
                icon: const Icon(Icons.filter_list_rounded),
                onPressed: () {
                  _openFilterModal(context);
                }),
            IconButton(
              style: style,
              tooltip: "Refresh",
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _refreshLibrary(context);
              },
            ),
          ],
        ),
        body: FutureBuilder(
            future: fetchLibrary(),
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
                  _cachedLibraryItems = snapshot.data;
                  _sortedLibraryItems = applySortAndFilters();

                  // build tile view
                  if (_displayType == DisplayType.tile) {
                    return Text("todo");
                    // return ListView.builder(
                    //     padding: const EdgeInsets.only(
                    //         top: 10, bottom: 10, left: 10, right: 10),
                    //     itemCount: snapshot.data!.length,
                    //     itemBuilder: (_, index) => InkWell(
                    //           onTap: () {
                    //             Navigator.push(context,
                    //                 MaterialPageRoute(builder: (context) {
                    //               return DetailBookPage(
                    //                   book: snapshot.data![index]);
                    //             }));
                    //           },
                    //           child: BookTile(book: snapshot.data![index]),
                    //         ));
                  }

                  // build grid view
                  else {
                    return GridView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 4.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: AppData().bookAspectRatio,
                          crossAxisCount: 3,
                        ),
                        itemCount: _sortedLibraryItems.length,
                        itemBuilder: (context, index) {
                          return LibraryTile(
                            item: _sortedLibraryItems[index],
                          );
                        });
                  }
                }
              }
            }));
  }
}
