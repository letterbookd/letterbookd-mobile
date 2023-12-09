import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:letterbookd/core/screens/librarian_homepage.dart';
import 'package:letterbookd/main.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();

  String _isbn13 = "";
  String _title = "";
  String _authors = "";
  String _categories = "";
  String _thumbnail = "";
  String _description = "";
  String _publishedYear = "";
  String _pageCount = "";

  Future<Map<String, dynamic>> _addBook(
    CookieRequest request,
  ) async {
    final response = await request.postJson(
                      '${AppData().url}/catalog/add-book-flutter/',
                      jsonEncode(<String, String>{
                          'isbn13': _isbn13,
                          'title': _title,
                          'authors': _authors,
                          'categories': _categories,
                          'thumbnail': _thumbnail,
                          'description': _description,
                          'publised_year': _publishedYear,
                          'page_count': _pageCount,
                      }));
    
    return response;
  }

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Book"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("ISBN: "),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "ISBN",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _isbn13 = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "ISBN tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "ISBN harus berupa angka!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),

                const Text("Title: "),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Title tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),

                const Text("Authors: "),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Authors",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _authors = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Authors tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),

                const Text("Categories: "),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Categories",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _categories = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Title tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),

                const Text("Thumbnail: "),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnail = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Thumbnail tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),

                const Text("Published year: "),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Published year",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _publishedYear = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Published year tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Published year harus berupa angka!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),

                const Text("Page count: "),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Page count",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _pageCount = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Published year tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Published year harus berupa angka!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),

                const Text("Description: "),
                const SizedBox(height: 16),
                TextFormField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Description tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),

                const SizedBox(height: 20,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final response = await _addBook(request);
                          if (response['status'] == 'success') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                              content: Text("Buku baru berhasil ditambahkan!"),
                              ));
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                const LibrarianHomePage()), (Route<dynamic> route) => false);
                          } else {
                              ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(const SnackBar(
                                  content:
                                      Text("Terdapat kesalahan, silakan coba lagi.")));
                          }
                        }
                      },
                      child: const Text(
                        "Add Book",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
