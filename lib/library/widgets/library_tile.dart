import 'package:flutter/material.dart';
import 'package:letterbookd/library/screens/library_detail.dart';

/// Grid tile for library homepage
class LibraryTile extends StatelessWidget {
  const LibraryTile({super.key});

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
              builder: (context) => const LibraryBookDetailPage(),
            ),
          );
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          fit: StackFit.expand,
          children: [
            /// TODO: replace with proper book cover
            const Image(
              image: NetworkImage(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
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

                /// TODO: replace with proper book title
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Book Title",
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
