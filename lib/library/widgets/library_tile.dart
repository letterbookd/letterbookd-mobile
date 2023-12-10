import 'package:flutter/material.dart';
import 'package:letterbookd/library/screens/library_detail.dart';
import 'package:letterbookd/library/screens/library_home.dart';

/// Grid tile for library homepage
class LibraryTile extends StatelessWidget {
  final LibraryItem item;

  const LibraryTile({super.key, required this.item});

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
            Image(
              image: NetworkImage(item.bookData.fields.authors),
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
