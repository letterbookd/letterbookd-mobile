import 'package:flutter/material.dart';
import 'package:letterbookd/library/screens/library_home.dart';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;

class LibraryDetailHeader extends StatelessWidget {
  final LibraryItem item;

  const LibraryDetailHeader({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20.00),
        height: 180,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: app_data.bookAspectRatio,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    child: Image.network(
                      item.bookData.fields.thumbnail,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Center();
                      },
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
                            item.bookData.fields.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "by ${item.bookData.fields.authors.split(';').map((author) => author).join(', ')}",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            item.bookData.fields.publishedYear.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6.0),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Text(
                              app_data.trackingStatusList[
                                  item.libraryData.fields.trackingStatus],
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                          ),
                        ])))
          ],
        ));
  }
}
