import 'package:flutter/material.dart';
import 'package:letterbookd/library/screens/library_home.dart';
import 'package:letterbookd/library/widgets/library_detail_actions.dart';
import 'package:letterbookd/library/widgets/library_detail_header.dart';

class LibraryBookDetailPage extends StatefulWidget {
  final LibraryItem item;

  const LibraryBookDetailPage({super.key, required this.item});

  @override
  State<LibraryBookDetailPage> createState() => _LibraryBookDetailPageState();
}

class _LibraryBookDetailPageState extends State<LibraryBookDetailPage> {
  void _editStatus(BuildContext context) {
    var currencies = [
      "Food",
      "Transport",
      "Personal",
      "Shopping",
      "Medical",
      "Rent",
      "Movie",
      "Salary"
    ];
    var _currentSelectedValue = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Tracking Status'),
          content: SingleChildScrollView(
              child: FormField<String>(builder: (FormFieldState<String> state) {
            return InputDecorator(
              isEmpty: _currentSelectedValue == '',
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                labelText: 'Tracking status',
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _currentSelectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      _currentSelectedValue = newValue.toString();
                      state.didChange(newValue);
                    });
                  },
                  items: currencies.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          })),
          actions: <Widget>[
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                // TODO: update the tracking status
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // TODO: delete library book from library
  void _deleteFromLibrary(BuildContext context) {
    // STEP 1: navigate back to previous, show snackbar as a progress start
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Removing from library'),
        ),
      );

    // STEP 2: send delete POST request

    // STEP 3: update with snackbar and refresh library
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onBackground,
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              style: style,
              tooltip: "Change Status",
              icon: const Icon(Icons.edit),
              onPressed: () {
                _editStatus(context);
              }),
          IconButton(
              tooltip: "Remove",
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteFromLibrary(context);
              }),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // HEADER: Cover, Title, Author(s), Year, Tracking status
            LibraryDetailHeader(item: widget.item),

            // ACTIONS: Favorite, Open in catalog, See reviews
            LibraryDetailActions(item: widget.item),

            // BODY: description
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  widget.item.bookData.fields.description,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
