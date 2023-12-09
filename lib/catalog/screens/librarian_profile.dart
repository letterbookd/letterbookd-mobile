import 'package:flutter/material.dart';

class LibrarianProfile extends StatefulWidget {
  const LibrarianProfile({super.key});

  @override
  _LibrarianProfileState createState() => _LibrarianProfileState();

}

class _LibrarianProfileState extends State<LibrarianProfile> {
  // TODO: show librarian's username
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Text(
              "Username: []",
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold,),
            ),
            SizedBox(height: 7.0),
          ],
        ),
      ),
    );
  }
}
