import 'package:flutter/material.dart';

class LibraryFilterModal extends StatefulWidget {
  const LibraryFilterModal({super.key});

  @override
  State<LibraryFilterModal> createState() => _LibraryFilterModalState();
}

class _LibraryFilterModalState extends State<LibraryFilterModal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
    );
  }
}
