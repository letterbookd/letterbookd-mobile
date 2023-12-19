import 'package:flutter/material.dart';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;
import 'package:letterbookd/library/screens/library_detail.dart';
import 'package:letterbookd/library/screens/library_home.dart';

/// Grid tile for library homepage
class LibraryGridTile extends StatelessWidget {
  final LibraryItem item;

  const LibraryGridTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LibraryBookDetailPage(item: item),
            ),
          );
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          fit: StackFit.expand,
          children: [
            Image.network(
              item.bookData.fields.thumbnail,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Center();
              },
              fit: BoxFit.fitHeight,
            ),
            Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.black.withAlpha(0),
                      Colors.black.withAlpha(0),
                      Colors.black45
                    ],
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    item.bookData.fields.title,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

// List tiel for library homepage
class LibraryListTile extends StatelessWidget {
  final LibraryItem item;

  const LibraryListTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        child: Row(
          children: [
            SizedBox(
              width: 70,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(0)),
                child: AspectRatio(
                  aspectRatio: app_data.bookAspectRatio,
                  child: Image.network(item.bookData.fields.thumbnail,
                      fit: BoxFit.fitHeight),
                ),
              ),
            ),
            Flexible(
                child: Container(
              padding: const EdgeInsets.only(left: 12, right: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.bookData.fields.title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                      "by ${item.bookData.fields.authors.split(';').map((author) => author).join(', ')}"),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Text(
                      LibraryData().trackingStatusList[
                          item.libraryData.fields.trackingStatus],
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      )),
    );
  }
}
