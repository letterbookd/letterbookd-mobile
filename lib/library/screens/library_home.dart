import 'package:flutter/material.dart';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;
import 'package:letterbookd/catalog/models/book.dart';
import 'package:letterbookd/library/screens/library_add.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:letterbookd/library/models/librarybook.dart';
import 'package:letterbookd/library/widgets/library_filter_modal.dart';
import 'package:letterbookd/library/widgets/library_tile.dart';

// filter and sort types
enum DisplayType {
  list,
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
  late List<Book> _cachedCatalogBooks;

  DisplayType _displayType = DisplayType.grid;
  SortBy _sortBy = SortBy.title;
  SortDirection _sortDirection = SortDirection.descending;
  FilterBy _filterBy = FilterBy.all;

  void _addBookForm(BuildContext context, CookieRequest request) async {
    if (_cachedCatalogBooks.isEmpty) {
      _cachedCatalogBooks = await _fetchBooks(request);
    }
    if (!context.mounted) return;

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LibraryAddForm(
                  books: _cachedCatalogBooks,
                  libbook: _cachedLibraryItems,
                ))).then((value) {
      if (value == true) {
        setState(() {});
      }
    });
  }

  void _openFilterModal(BuildContext context) {
    showModalBottomSheet(
      useRootNavigator: true,
      showDragHandle: true,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return const LibraryFilterModal();
      },
    ).then((value) {
      SortBy? newSort;
      FilterBy? newFilterBy;
      SortDirection? newSortDir;
      DisplayType? newDisplayType;

      if (value == "title") {
        newSort = SortBy.title;
      } else if (value == "recentlyAdded") {
        newSort = SortBy.recentlyAdded;
      } else if (value == "trackingStatus") {
        newSort = SortBy.trackingStatus;
      } else if (value == "all") {
        newFilterBy = FilterBy.all;
      } else if (value == "favorites") {
        newFilterBy = FilterBy.favorites;
      } else if (value == "finished") {
        newFilterBy = FilterBy.finished;
      } else if (value == "reading") {
        newFilterBy = FilterBy.reading;
      } else if (value == "onHold") {
        newFilterBy = FilterBy.onHold;
      } else if (value == "planned") {
        newFilterBy = FilterBy.planned;
      } else if (value == "dropped") {
        newFilterBy = FilterBy.dropped;
      } else if (value == "reviewed") {
        newFilterBy = FilterBy.reviewed;
      } else if (value == "list") {
        newDisplayType = DisplayType.list;
      } else if (value == "grid") {
        newDisplayType = DisplayType.grid;
      } else if (value == "ascending") {
        newSortDir = SortDirection.ascending;
      } else if (value == "descending") {
        newSortDir = SortDirection.descending;
      } else {
        return;
      }

      setState(() {
        _sortBy = newSort ?? _sortBy;
        _filterBy = newFilterBy ?? _filterBy;
        _sortDirection = newSortDir ?? _sortDirection;
        _displayType = newDisplayType ?? _displayType;
      });
    });
  }

  void _refreshLibrary(BuildContext context) async {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Refreshing library'),
        ),
      );
    setState(() {}); // refresh library
  }

  /// Getting all libraryBook in user
  Future<List<LibraryItem>> _fetchLibrary(CookieRequest request) async {
    var response = await request.get(
      '${app_data.baseUrl}/library/api/get/',
    );

    // melakukan decode response menjadi bentuk json
    List<LibraryItem> libraryItem = [];
    for (var i = 0; i < response["library"][0].length; i++) {
      libraryItem.add(LibraryItem(
          LibraryBook.fromJson(response["library"][0][i]),
          Book.fromJson(response["library"][1][i])));
    }

    return libraryItem;
  }

  /// Getting all books in catalog for adding to library
  Future<List<Book>> _fetchBooks(
    CookieRequest request,
  ) async {
    final response = await request.get('${app_data.baseUrl}/catalog/json/');

    List<Book> books = [];
    for (var d in response) {
      if (d != null) {
        books.add(Book.fromJson(d));
      }
    }

    return books;
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
    final request = context.watch<CookieRequest>();

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
                  _addBookForm(context, request);
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
            future: _fetchLibrary(request),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    if (!snapshot.hasData || snapshot.data.length == 0) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Your library is empty :(",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  _addBookForm(context, request);
                                },
                                child: const Text("Add book")),
                          ],
                        ),
                      );
                    } else {
                      _cachedLibraryItems = snapshot.data;
                      _cachedCatalogBooks = [];
                      _sortedLibraryItems = applySortAndFilters();

                      if (_sortedLibraryItems.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No book matching your filters",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    _openFilterModal(context);
                                  },
                                  child: const Text("Open sort and filters")),
                            ],
                          ),
                        );
                      }

                      // build tile view
                      if (_displayType == DisplayType.list) {
                        return ListView.builder(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 10, right: 10),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return LibraryListTile(
                                item: _sortedLibraryItems[index],
                                refreshLibrary: () {
                                  print("#### pleae");
                                  _refreshLibrary(context);
                                },
                              );
                            });
                      }

                      // build grid view
                      else {
                        return GridView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 4.0),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: app_data.bookAspectRatio,
                              crossAxisCount: 3,
                            ),
                            itemCount: _sortedLibraryItems.length,
                            itemBuilder: (context, index) {
                              return LibraryGridTile(
                                item: _sortedLibraryItems[index],
                                refreshLibrary: () {
                                  print("#### pleae");
                                  _refreshLibrary(context);
                                },
                              );
                            });
                      }
                    }
                  }
              }
            }));
  }
}
