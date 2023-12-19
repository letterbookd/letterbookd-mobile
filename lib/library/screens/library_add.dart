import 'package:flutter/material.dart';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LibraryAddForm extends StatefulWidget {
  const LibraryAddForm({super.key});

  @override
  State<LibraryAddForm> createState() => _LibraryAddFormState();
}

// TODO: add buku ke library
class _LibraryAddFormState extends State<LibraryAddForm> {
  void _addBookToLibrary(BuildContext context, CookieRequest request) async {
    // STEP 1: Validate Form

    // STEP 2: POST request
    var response = await request.post('${app_data.baseUrl}/library/api/add  /',
        {'book_id': "-1"}); // TODO: replace with actual id from form

    // STEP 3: PROCESS response
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Added BOOK_NAME to library!'),
      ),
    );
    Navigator.of(context).pop();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addBookToLibrary(context, request);
        },
        tooltip: 'Add book',
        child: const Icon(Icons.check),
      ),
    );
  }
}
