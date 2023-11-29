import 'package:flutter/material.dart';
import 'package:letterbookd/library/widgets/library_tile.dart';

/// ini contoh
class LibraryHome extends StatelessWidget {
  const LibraryHome({super.key});

  void _openFilterModal() {}

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onBackground,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Library"),
        actions: <Widget>[
          IconButton(
              style: style,
              tooltip: "Filter",
              icon: const Icon(Icons.filter_list_rounded),
              onPressed: () {
                showModalBottomSheet<void>(
                  showDragHandle: true,
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 500,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Modal BottomSheet'),
                            ElevatedButton(
                              child: const Text('Close BottomSheet'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
          IconButton(
            style: style,
            tooltip: "Refresh",
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
        alignment: Alignment.topCenter,
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 181 / 291,
              crossAxisCount: 3,
            ),
            itemCount: 18,
            itemBuilder: (context, index) {
              return const LibraryTile();
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        // foregroundColor: ,
        // backgroundColor: customizations[index].$2,
        icon: const Icon(
          Icons.book,
          weight: 5.0,
        ),
        label: const Text("Add book"),
      ),
    );
  }
}
