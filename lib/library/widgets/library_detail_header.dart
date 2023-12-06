import 'package:flutter/material.dart';
import 'package:letterbookd/main.dart';

class LibraryDetailHeader extends StatelessWidget {
  const LibraryDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20.00),
        height: 180,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: AppData().bookAspectRatio,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: const InkWell(
                    child: Image(
                      image: NetworkImage(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                      fit: BoxFit.fitHeight,
                    ),
                  )),
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Book Title", // TODO: repalce with libBook.fields.title
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          Text(
                            "by Author(s)", // TODO: repalce with libBook.fields.authors
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                          Text(
                            "1999", // TODO: repalce with libBook.fields.release_year
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                        ])))
          ],
        ));
  }
}
