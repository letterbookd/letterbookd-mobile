import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/models/book.dart';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;
import 'package:letterbookd/library/screens/library_home.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LibraryAddForm extends StatefulWidget {
  final List<Book> books;
  final List<LibraryItem> libbook;
  const LibraryAddForm({super.key, required this.books, required this.libbook});

  @override
  State<LibraryAddForm> createState() => _LibraryAddFormState();
}

class _LibraryAddFormState extends State<LibraryAddForm> {
  late List<Book> availableBooks;

  void _addBookToLibrary(BuildContext context, CookieRequest request) async {
    // STEP 1: Validate Form

    // STEP 2: POST request
    final response =
        await request.post('${app_data.baseUrl}/library/api/add/', {
      'book_id': _selectedBook.pk.toString(),
      'isFavorited': _isFavorite.toString(),
      'trackingStatus': _trackingStatus.toString(),
    });

    // STEP 3: PROCESS response
    if (!context.mounted) return;

    if (!response["status"]) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Book is already in Library'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Added ${_selectedBook.fields.title} to library!'),
      ),
    );
    Navigator.of(context).pop(true);
  }

  final _formKey = GlobalKey<FormState>();

  late Book _selectedBook;
  bool _isFavorite = false;
  int _trackingStatus = 1;

  @override
  void initState() {
    super.initState();
    availableBooks = widget.books;
    setState(() {
      _selectedBook = availableBooks.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add book to Library"),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
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
                                    _selectedBook.fields.thumbnail,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondaryContainer,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      );
                                    },
                                    fit: BoxFit.fitHeight,
                                  ),
                                )),
                          ),
                          Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        FormField<String>(builder:
                                            (FormFieldState<String> state) {
                                          return InputDecorator(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18.0,
                                                      vertical: 8.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                              labelText: 'Tracking Status',
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<Book>(
                                                isExpanded: true,
                                                autofocus: true,
                                                value: _selectedBook,
                                                onChanged: (Book? newValue) {
                                                  setState(() {
                                                    _selectedBook = newValue!;
                                                    state.didChange(
                                                        newValue.toString());
                                                  });
                                                },
                                                items: availableBooks
                                                    .map((Book value) {
                                                  return DropdownMenuItem<Book>(
                                                    value: value,
                                                    child: Text(
                                                        value.fields.title),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          );
                                        }),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          "by ${_selectedBook.fields.authors.split(';').map((author) => author).join(', ')}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              ),
                                        ),
                                        const SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          _selectedBook.fields.publishedYear
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              ),
                                        ),
                                        const SizedBox(
                                          height: 4.0,
                                        ),
                                      ])))
                        ],
                      )),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Column(
                        children: [
                          FormField<String>(
                              builder: (FormFieldState<String> state) {
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
                                  value: _trackingStatus,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      _trackingStatus = newValue!;
                                      state.didChange(newValue.toString());
                                    });
                                  },
                                  items: List.generate(
                                      app_data.trackingStatusList.length,
                                      (i) => DropdownMenuItem<int>(
                                            value: i,
                                            child: Text(
                                                app_data.trackingStatusList[i]),
                                          )),
                                ),
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Row(children: [
                            Expanded(
                              child: Text(
                                "Add to Favorites",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            Switch(
                              // This bool value toggles the switch.
                              value: _isFavorite,
                              onChanged: (bool value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  _isFavorite = value;
                                });
                              },
                            ),
                          ]),
                        ],
                      )),
                ],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _addBookToLibrary(context, request);
          }
        },
        tooltip: 'Add book',
        child: const Icon(Icons.check),
      ),
    );
  }
}
