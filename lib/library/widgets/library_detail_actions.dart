import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:letterbookd/library/models/librarybook.dart';

class LibraryDetailActions extends StatefulWidget {
  // TODO: final LibraryBook libBook;

  const LibraryDetailActions({super.key});
  @override
  State<LibraryDetailActions> createState() => new _LibraryDetailActionsState();
}

class _LibraryDetailActionsState extends State<LibraryDetailActions> {
  bool _isFavorited = false;
  bool _isFavoriteDisabled = false;

  @override
  Widget build(BuildContext context) {
    // TODO: toggles favorite
    void toggleFavorite(BuildContext context) {
      // STEP 1: disable button as a debounce
      setState(() {
        _isFavoriteDisabled = true;
        _isFavorited = !_isFavorited;
      });

      // STEP 2: sends POST request to toggle current item favorite
      // STEP 3: listens to request and update UI accordingly
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Favorited!'),
        ),
      );

      setState(() {
        _isFavoriteDisabled = false;
      });
    }

    // TODO: navigates to this book's review page
    void openReviews(BuildContext context) {
      // STEP 1: Navigator push to review page of the book
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('TODO: navigate to book\'s review page'),
        ),
      );
    }

    // TODO: navigates to this book's catalog page
    void openCatalog(BuildContext context) {
      // STEP 1: Navigator push to catalog page of the book
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('TODO: navigate to book\'s catalog page'),
        ),
      );
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
                      Text(_isFavorited ? "Unfavorite" : "Favorite"),
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
