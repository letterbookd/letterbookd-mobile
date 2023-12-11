import 'package:flutter/material.dart';

class LibraryUpdateModal extends StatefulWidget {
  const LibraryUpdateModal({Key? key}) : super(key: key);

  @override
  State<LibraryUpdateModal> createState() => _LibraryUpdateModal();
}

class _LibraryUpdateModal extends State<LibraryUpdateModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(),
    ));
  }
}
