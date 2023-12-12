import 'package:flutter/material.dart';

class LibraryUpdateModal extends StatefulWidget {
  const LibraryUpdateModal({super.key});

  @override
  State<LibraryUpdateModal> createState() => _LibraryUpdateModal();
}

class _LibraryUpdateModal extends State<LibraryUpdateModal> {
  @override
  Widget build(BuildContext context) {
    return const Dialog(
        child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(),
    ));
  }
}
