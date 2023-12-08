import 'package:flutter/material.dart';
import 'package:letterbookd/library/widgets/library_filter_modal.dart';
import 'package:letterbookd/library/widgets/library_tile.dart';
import 'package:letterbookd/main.dart';

class LibraryData {
  final List<String> trackingStatusList = [
    "Finished Reading",
    "Currently Reading",
    "On Hold",
    "Planning to Read",
    "Dropped",
  ];
}

class LibraryHome extends StatelessWidget {
  const LibraryHome({super.key});

  void _addBookForm(BuildContext context) {}

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
              tooltip: "Add book",
              icon: const Icon(Icons.add),
              onPressed: () {
                _addBookForm(context);
              }),
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
        child: GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: AppData().bookAspectRatio,
              crossAxisCount: 3,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              return const LibraryTile();
            }),
      ),
    );
  }
}
