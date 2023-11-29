import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LibraryAddForm extends StatefulWidget {
  const LibraryAddForm({super.key});

  @override
  State<LibraryAddForm> createState() => _LibraryAddFormState();
}

class _LibraryAddFormState extends State<LibraryAddForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold();
  }
}
