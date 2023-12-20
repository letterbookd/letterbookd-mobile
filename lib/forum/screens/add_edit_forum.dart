import 'dart:convert';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AddForumPage extends StatefulWidget {
  const AddForumPage(
      {required this.isEdit, this.title, this.content, this.pk, super.key});
  final bool isEdit;
  final int? pk;
  final String? title;
  final String? content;
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

      return response;
    } catch (e) {
      throw Exception('error : $e');
    }
  }

  Future<Map<String, dynamic>> _editThread(
    CookieRequest request,
    String title,
    String content,
    int pk,
  ) async {
    try {
      final response = await request.post(
          '${app_data.baseUrl}/forum/edit-json/$pk/',
          jsonEncode(
            {
              'title': title,
              'content': content,
            },
          ));

      return response;
    } catch (e) {
      throw Exception('error : $e');
    }
  }

  @override
  void initState() {
    widget.title != null
        ? _titleController.text = widget.title!
        : _titleController.text = "";
    widget.content != null
        ? _contentController.text = widget.content!
        : _contentController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: !widget.isEdit
            ? const Text("Add New Thread")
            : const Text("Edit Thread"),
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
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (!widget.isEdit) {
                            _postThread(request, _titleController.text,
                                _contentController.text);
                          }

                          if (widget.isEdit) {
                            _editThread(request, _titleController.text,
                                _contentController.text, widget.pk!);
                          }

                          Navigator.of(context).pop();
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
