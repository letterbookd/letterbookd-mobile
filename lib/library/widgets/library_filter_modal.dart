import 'package:flutter/material.dart';

class LibraryFilterModal extends StatefulWidget {
  const LibraryFilterModal({super.key});

  @override
  State<LibraryFilterModal> createState() => _LibraryFilterModalState();
}

class _LibraryFilterModalState extends State<LibraryFilterModal> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Filter Modal'),
            ElevatedButton(
              child: const Text('Close BottomSheet'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
