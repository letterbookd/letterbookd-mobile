import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:letterbookd/main.dart';

class LibrarianProfile extends StatefulWidget {
  const LibrarianProfile({super.key});

  @override
  _LibrarianProfileState createState() => _LibrarianProfileState();

}

class _LibrarianProfileState extends State<LibrarianProfile> {

  Future<String> _getUsername(
    CookieRequest request,
  ) async {
    final response = await request.get('${AppData().url}/catalog/get-username/');

    return response['username'];
  }

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            FutureBuilder<String>(
              future: _getUsername(request),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } 
                else {
                  return Text(
                    "Username: ${snapshot.data}",
                    style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold,),
                  );
                }
              },
            ),
            const SizedBox(height: 7.0),
          ],
        ),
      ),
    );
  }
}
