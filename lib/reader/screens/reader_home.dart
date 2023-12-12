import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:letterbookd/main.dart';
import 'package:letterbookd/reader/models/reader.dart';
import 'package:letterbookd/reader/screens/reader_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReaderHome extends StatefulWidget {
  const ReaderHome({super.key});

  @override
  ReaderHomeState createState() => ReaderHomeState();
}

class ReaderHomeState extends State<ReaderHome> {
  bool isSearchMode = false;
  bool hasSearched = false;
  List<ReaderElement> listReaders = [];
  TextEditingController searchController = TextEditingController();

  Future<String?> _getSavedUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<ReaderElement?> fetchReaders() async {
    String? username = await _getSavedUsername();

    if (username != null) {
      var url = Uri.parse('${AppData().url}/reader/get-reader-json/');
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Username": username,
        },
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        return ReaderElement.fromJson(jsonData);
      } else {
        throw Exception('Failed to load reader');
      }
    }

    return null;
  }

  Future<List<ReaderElement>> searchReaders(String query) async {
    String? username = await _getSavedUsername();

    if (username != null) {
      var url = Uri.parse('${AppData().url}/reader/search-readers?q=$query');
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Username": username,
        },
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(utf8.decode(response.bodyBytes));

        if (jsonData is List && jsonData.isNotEmpty) {
          List<ReaderElement> searchResults = List<ReaderElement>.from(
            jsonData.map((e) => ReaderElement.fromJson(e)),
          );

          return searchResults;
        } else {
          debugPrint('No search results found.');
          return [];
        }
      } else {
        throw Exception('Failed to search readers');
      }
    }

    return [];
  }

  Widget _buildBody(BuildContext context, List<ReaderElement> readers) {
    return ListView(
      children: [
        const SizedBox(height: 16),
        // Display search results or user profile
        if (isSearchMode)
          _buildSearchResults(context, readers)
        else
          FutureBuilder<ReaderElement?>(
            future: fetchReaders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text("Tidak ada data pembaca."));
              } else {
                final reader = snapshot.data!;
                return Column(
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/pfp_0.jpg'),
                      ),
                    ),
                    _buildUserInfoCard('Username', reader.displayName),
                    _buildUserInfoCard('Bio', reader.bio),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                        ).then((result) {
                          if (result != null && result == true) {
                            setState(() {});
                          }
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        child: const Text(
                          'Edit Profile',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
      ],
    );
  }

  /*
  Widget _buildSearchResults(
      BuildContext context, List<ReaderElement> readers) {
    debugPrint(readers.toString());
    return Column(
      children: [
        for (var reader in readers) _buildReaderCard(reader),
      ],
    );
  }
  */

  Widget _buildSearchResults(
      BuildContext context, List<ReaderElement> readers) {
    // Jika daftar readers kosong, tampilkan pesan "No readers found"
    if (readers.isEmpty && hasSearched) {
      return const Center(
        child: Text('No readers found'),
      );
    }

    // Jika ada hasil, tampilkan kartu pembaca
    return Column(
      children: [
        for (var reader in readers) _buildReaderCard(reader),
      ],
    );
  }

  /*
  Widget _buildReaderCard(ReaderElement reader) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(reader.displayName),
            subtitle: Text(reader.bio),
          ),
        ],
      ),
    );
  }
  */

  Widget _buildReaderCard(ReaderElement reader) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              AssetImage('assets/images/pfp_0.jpg'), // Gambar profil
        ),
        title: Text(reader.displayName),
        subtitle: Text(reader.bio),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearchMode ? _buildSearchAppBar() : _buildRegularAppBar(),
      body: _buildBody(context, listReaders),
    );
  }

  AppBar _buildRegularAppBar() {
    return AppBar(
      title: const Text('Readers'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              listReaders = [];
              hasSearched = false;
              searchController.text = "";
              isSearchMode = true;
            });
          },
        ),
      ],
    );
  }

  AppBar _buildSearchAppBar() {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          setState(() {
            isSearchMode = false;
          });
        },
      ),
      title: TextField(
        controller: searchController,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: "Search...",
          border: InputBorder.none,
        ),
        onSubmitted: (value) {
          // Handle search here
          searchReaders(value).then((results) {
            setState(() {
              listReaders = results;
              hasSearched = true;
            });
          });
        },
      ),
    );
  }

  Widget _buildUserInfoCard(String title, String content) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(content),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      ),
    );
  }
}
