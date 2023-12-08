import 'package:flutter/material.dart';
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
    var url = Uri.parse('http://10.0.2.2:8080/reader/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Reader> listReaders = [];

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
      body: _buildBody(context),
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
          // Handle search here
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return FutureBuilder<List<Reader>>(
      future: fetchReaders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Tidak ada data pembaca."));
        } else {
          final readers = snapshot.data!;
          return ListView.builder(
            itemCount: readers.length,
            itemBuilder: (context, index) {
              final reader = readers[index];
              return _buildReaderCard(reader);
            },
          );
        }
      },
    );
  }

  Widget _buildReaderCard(Reader reader) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(reader.fields.displayName),
            subtitle: Text(reader.fields.bio),
          ),
        ],
      ),
    );
  }
}
