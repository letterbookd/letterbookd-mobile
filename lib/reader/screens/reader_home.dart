import 'package:flutter/material.dart';
import 'package:letterbookd/reader/screens/reader_settings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:letterbookd/reader/models/reader.dart';

class ReaderHome extends StatefulWidget {
  const ReaderHome({super.key});

  @override
  ReaderHomeState createState() => ReaderHomeState();
}

class ReaderHomeState extends State<ReaderHome> {
  bool isSearchMode = false;

  Future<List<Reader>> fetchReaders() async {
    // https://letterbookd-a09-tk.pbp.cs.ui.ac.id/reader/get-reader-json/
    var url = Uri.parse(
        // http://10.0.2.2:8080/auth/login/
        'http://10.0.2.2:8080/reader/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Reader
    List<Reader> listReaders = [];
    /*
    for (var d in data) {
      listReaders.add(Reader.fromJson(d));
    }
    */
    for (var d in data) {
      if (d != null) {
        listReaders.add(Reader.fromJson(d));
      }
    }

    return listReaders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearchMode ? _buildSearchAppBar() : _buildRegularAppBar(),
      body: FutureBuilder<List<Reader>>(
        future: fetchReaders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Tidak ada data pembaca."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final reader = snapshot.data![index];
                return ListTile(
                  title: Text(reader.fields.displayName),
                  subtitle: Text(reader.fields.bio),
                );
              },
            );
          }
        },
      ),
    );
  }

  AppBar _buildRegularAppBar() {
    return AppBar(
      title: const Text("Reader"),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
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
        autofocus: true,
        decoration: const InputDecoration(
          hintText: "Search...",
          border: InputBorder.none,
        ),
        onSubmitted: (value) {
          // nanti search di sini
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

  Widget _buildGridSection(int itemCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 4,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Card(
          child: Container(),
        );
      },
    );
  }
}
