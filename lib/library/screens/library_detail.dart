import 'package:flutter/material.dart';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;
import 'package:letterbookd/library/screens/library_home.dart';
import 'package:letterbookd/library/widgets/library_detail_actions.dart';
import 'package:letterbookd/library/widgets/library_detail_header.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LibraryBookDetailPage extends StatefulWidget {
  final LibraryItem item;

  const LibraryBookDetailPage({super.key, required this.item});

  @override
  State<LibraryBookDetailPage> createState() => _LibraryBookDetailPageState();
}

class _LibraryBookDetailPageState extends State<LibraryBookDetailPage> {
  bool _changed = false;
  void _editStatus(BuildContext context, CookieRequest request) {
    var trackingStatus = widget.item.libraryData.fields.trackingStatus;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Tracking Status'),
          content: SingleChildScrollView(
            child: FormField<String>(builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 8.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  labelText: 'Tracking Status',
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    isExpanded: true,
                    autofocus: true,
                    value: trackingStatus,
                    onChanged: (int? newValue) {
                      setState(() {
                        trackingStatus = newValue!;
                        state.didChange(newValue.toString());
                      });
                    },
                    items: List.generate(
                        app_data.trackingStatusList.length,
                        (i) => DropdownMenuItem<int>(
                              value: i,
                              child: Text(app_data.trackingStatusList[i]),
                            )),
                  ),
                ),
              );
            }),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Update'),
              onPressed: () async {
                // STEP 2: sends POST request to toggle current item favorite
                final response = await request.post(
                  '${app_data.baseUrl}/library/api/update/',
                  {
                    "book_id": widget.item.libraryData.fields.book.toString(),
                    "trackingStatus": trackingStatus.toString()
                  },
                );
                if (!context.mounted) return;

                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                if (response['status'] != true) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(response['message']),
                    ));
                  return;
                }

                setState(() {
                  widget.item.libraryData.fields.trackingStatus =
                      trackingStatus;
                  _changed = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteFromLibrary(BuildContext context, CookieRequest request) async {
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
    var response = await request.post('${app_data.baseUrl}/library/api/remove/',
        {'book_id': widget.item.bookData.pk.toString()});
    if (!context.mounted) return;

    // STEP 3: update with snackbar and refresh library
    if (response["status"]) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(response["message"]),
          ),
        );
      setState(() {
        _changed = true;
      });
      Navigator.of(context).pop(true);
    } else {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("Error deleting book [${response["statusCode"]}]"),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
                _editStatus(context, request);
              }),
          IconButton(
              tooltip: "Remove",
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteFromLibrary(context, request);
              }),
        ],
        leading: BackButton(
          onPressed: () => Navigator.pop(context, _changed),
        ),
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
            LibraryDetailActions(
              item: widget.item,
              callback: () {
                setState(() {
                  _changed = true;
                });
              },
            ),

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
