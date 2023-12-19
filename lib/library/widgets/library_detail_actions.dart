import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/screens/detail_book.dart';
import 'package:letterbookd/library/screens/library_home.dart';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
// import 'package:letterbookd/library/models/librarybook.dart';

class LibraryDetailActions extends StatefulWidget {
  final LibraryItem item;

  const LibraryDetailActions({super.key, required this.item});

  @override
  State<LibraryDetailActions> createState() => _LibraryDetailActionsState();
}

class _LibraryDetailActionsState extends State<LibraryDetailActions> {
  bool _isFavorited = false;
  bool _isFavoriteDisabled = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    _isFavorited = widget.item.libraryData.fields.isFavorited;

    void toggleFavorite(BuildContext context) async {
      // STEP 1: disable button as a debounce
      setState(() {
        _isFavoriteDisabled = true;
        _isFavorited = !widget.item.libraryData.fields.isFavorited;
        widget.item.libraryData.fields.isFavorited = _isFavorited;
      });

      // STEP 2: sends POST request to toggle current item favorite
      final response = await request.post(
        '${app_data.baseUrl}/library/api/update/',
        {
          "book_id": widget.item.libraryData.fields.book.toString(),
          "isFavorited": _isFavorited.toString()
        },
      );
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      if (response['status'] != true) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(response['message']),
          ));

        setState(() {
          _isFavoriteDisabled = false;
        });
        return;
      }

      // STEP 3: listens to request and update UI accordingly
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(_isFavorited ? 'Favorited!' : 'Removed from Favorites'),
        ));

      setState(() {
        _isFavoriteDisabled = false;
      });
    }

    // TODO: navigates to this book's review page
    void openReviews(BuildContext context) {
      // STEP 1: Navigator push to review page of the book
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return DetailBookPage(book: widget.item.bookData);
      }));
    }

    void openCatalog(BuildContext context) {
      // STEP 1: Navigator push to catalog page of the book
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return DetailBookPage(book: widget.item.bookData);
      }));
    }

    return Container(
        margin: const EdgeInsets.only(bottom: 16.00),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextButton(
                  onPressed: _isFavoriteDisabled
                      ? null
                      : () {
                          toggleFavorite(context);
                        },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        _isFavorited ? Icons.favorite : Icons.favorite_outline,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(_isFavorited ? "In favorites" : "Favorite"),
                    ],
                  )),
            ),
            Expanded(
              child: TextButton(
                  onPressed: () {
                    openReviews(context);
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.reviews_outlined,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text("See reviews"),
                    ],
                  )),
            ),
            Expanded(
              child: TextButton(
                  onPressed: () {
                    openCatalog(context);
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.open_in_new,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text("More details"),
                    ],
                  )),
            ),
          ],
        ));
  }
}
