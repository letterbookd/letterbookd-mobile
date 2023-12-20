import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;
import 'package:letterbookd/authenticate/screens/login.dart';

class LibrarianProfile extends StatefulWidget {
  const LibrarianProfile({super.key});

  @override
  State<LibrarianProfile> createState() => _LibrarianProfileState();
}

class _LibrarianProfileState extends State<LibrarianProfile> {
  Future<String> _getUsername(CookieRequest request) async {
    final response =
        await request.get('${app_data.baseUrl}/catalog/get-username/');

    return response['username'];
  }

  Future<void> logout(CookieRequest request) async {
    final response = await request.logout('${app_data.baseUrl}/auth/logout/');
    String message = response["message"];
    if (!context.mounted) return;
    if (response['status']) {
      String uname = response["username"];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$message Sampai jumpa, $uname."),
      ));
      Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const LoginPage()),
              (Route<dynamic> route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Librarian Profile'),
        actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            logout(request);
          },
        ),
      ],
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            FutureBuilder<String>(
              future: _getUsername(request),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: const Text("Librarian Username:"),
                      subtitle: Text("${snapshot.data}") ,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    ),
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
