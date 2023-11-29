import 'package:flutter/material.dart';
import 'package:letterbookd/library/widgets/library_filter_modal.dart';
import 'package:letterbookd/library/widgets/library_tile.dart';

/// ini contoh
class LibraryHome extends StatelessWidget {
  const LibraryHome({super.key});

  void _openFilterModal(BuildContext context) {
    showModalBottomSheet<void>(
      useRootNavigator: true,
      showDragHandle: true,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return const LibraryFilterModal();
      },
    );
  }

  void _refreshLibrary(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Refreshing library'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        padding: const EdgeInsets.all(8.0),
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
        icon: const Icon(
          Icons.book,
        ),
        label: const Text("Add book"),
      ),
    );
  }
}
