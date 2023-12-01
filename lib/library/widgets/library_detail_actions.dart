import 'package:flutter/material.dart';

class LibraryDetailActions extends StatelessWidget {
  const LibraryDetailActions({super.key});

  @override
  Widget build(BuildContext context) {
    void toggleFavorite(BuildContext context) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Favorited!'),
        ),
      );
    }

    void openReviews(BuildContext context) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('TODO: navigate to book\'s review page'),
        ),
      );
    }

    void openCatalog(BuildContext context) {
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
                  onPressed: () {
                    toggleFavorite(context);
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_outline,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text("Favorite"),
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
