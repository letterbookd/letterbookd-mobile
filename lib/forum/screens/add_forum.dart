import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AddForumPage extends StatefulWidget {
  const AddForumPage({super.key});

  @override
  State<AddForumPage> createState() => _AddForumPageState();
}

class _AddForumPageState extends State<AddForumPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Future<Map<String, dynamic>> _postThread(
    CookieRequest request,
    String title,
    String content,
  ) async {
    try {
      final response = await request.post(
          '${app_data.baseUrl}/forum/create-json/',
          jsonEncode(
            {
              'title': title,
              'content': content,
            },
          ));

      // print(response);
      return response;
    } catch (e) {
      throw Exception('error : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Thread"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Thread Title: "),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: "Thread Title",
                    labelText: "Thread Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {});
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Title tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Thread Content: "),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _contentController,
                  decoration: InputDecoration(
                      hintText: "Write your thoughts...",
                      labelText: "Thread Content",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.15,
                          horizontal: 20)),
                  onChanged: (String? value) {
                    setState(() {});
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Content tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _postThread(request, _titleController.text,
                              _contentController.text);
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(const SnackBar(
                                content:
                                    Text("Data yang dimmasukan tidak valid!")));
                        }
                      },
                      child: const Text(
                        "Submit",
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
