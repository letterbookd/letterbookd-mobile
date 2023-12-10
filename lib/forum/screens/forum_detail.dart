// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:letterbookd/forum/models/thread.dart';
import 'package:letterbookd/forum/models/thread_detail.dart';
import 'package:letterbookd/forum/screens/add_edit_forum.dart';
//import 'package:letterbookd/forum/screens/forum_home.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ForumDetailPage extends StatefulWidget {
  const ForumDetailPage(
      {required this.createdAt,
      required this.threader,
      required this.pk,
      super.key});
  final String threader;
  final int pk;
  final String createdAt;

  @override
  State<ForumDetailPage> createState() => _ForumDetailPageState();
}

class _ForumDetailPageState extends State<ForumDetailPage> {
  bool isReply = true;
  late bool isLiked;
  bool isLikedChoosen = false;
  final TextEditingController _replyController = TextEditingController();

  Future<ThreadDetail> _fetchDetail(CookieRequest request, int pk) async {
    try {
      final response =
          await request.post('http://10.0.2.2:8000/forum/view-json/$pk/', {});

      ThreadDetail result = ThreadDetail.fromJson(response['data']);

      return result;
    } catch (e) {
      throw Exception('error : $e');
    }
  }

  void _postReply(CookieRequest request, int pk, String content) async {
    try {
      final response = await request.post(
          'http://10.0.2.2:8000/forum/reply-json/$pk/',
          jsonEncode(
            {
              'content': content,
            },
          ));

      if (response['status'] == true) {
        setState(() {});
      }
      print(response);
    } catch (e) {
      throw Exception('error : $e');
    }
  }

  void _postLike(
    CookieRequest request,
    int pk,
  ) async {
    try {
      final response =
          await request.post('http://10.0.2.2:8000/forum/like-json/$pk/', {});

      print(response);
    } catch (e) {
      throw Exception('error : $e');
    }
  }

  void _deleteThread(
    CookieRequest request,
    int pk,
  ) async {
    try {
      final response =
          await request.post('http://10.0.2.2:8000/forum/delete-json/$pk/', {});

      print(response);
    } catch (e) {
      throw Exception('error : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();

    return Scaffold(
        appBar: AppBar(
          title: Text("Forum Detail"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: _fetchDetail(request, widget.pk),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            isLiked = snapshot.data!.userLiked!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 1.6,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                child: Text(widget.threader[0].toUpperCase()),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text("@${widget.threader}")
                            ],
                          ),
                          PopupMenuButton(
                            onSelected: (String choice) {
                              if (choice == 'Edit') {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddForumPage(
                                    isEdit: true,
                                    title: snapshot.data!.title ?? "",
                                    content: snapshot.data!.threadContent ?? "",
                                    pk: widget.pk,
                                  ),
                                ));
                              } else if (choice == 'Delete') {
                                showDialog(
                                  context: context,
                                  builder: (
                                    BuildContext contextDialog,
                                  ) {
                                    return AlertDialog(
                                      title: const Text('Delete Post'),
                                      content: const Text(
                                          'Are you sure you want to delete this Thread?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            // Delete the comment and close the dialog
                                            _deleteThread(request, widget.pk);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Delete',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Close the dialog without deleting the comment
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel',
                                              style: TextStyle(
                                                  color: Colors.blue)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return ['Edit', 'Delete'].map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(
                                    choice,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList();
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        snapshot.data!.title ?? "",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        snapshot.data!.threadContent ?? "",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(),
                      Text(widget.createdAt),
                      Divider(),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isLikedChoosen = false;
                                  isReply = true;
                                });
                              },
                              icon: Icon(Icons.chat_bubble)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _postLike(request, widget.pk);
                                  isReply = isReply ? !isReply : isReply;
                                  isLikedChoosen = true;
                                  isLiked = !isLiked;
                                });
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: isLiked ? Colors.red : Colors.grey,
                              )),
                          Text("${snapshot.data!.likes!.length}")
                        ],
                      ),
                      Divider(),
                      if (isReply)
                        ...buildReply(
                            context, snapshot.data!.replies ?? [], request),
                      if (isLikedChoosen)
                        ...buildLike(context, snapshot.data!.likes ?? [])
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  List<Widget> buildReply(
    BuildContext context,
    List<Replies> replies,
    CookieRequest request,
  ) {
    return [
      Text(
        "Replies (${replies.length})",
        style: TextStyle(fontSize: 24),
      ),
      SizedBox(
        height: 20,
      ),
      Text("Message:"),
      SizedBox(
        height: 10,
      ),
      TextField(
        controller: _replyController,
        decoration: InputDecoration(
            hintText: "Write your thoughts...",
            labelText: "Thread Content",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.05,
                horizontal: 20)),
        onChanged: (String? value) {
          setState(() {});
        },
      ),
      SizedBox(
        height: 12,
      ),
      Center(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.indigo),
          ),
          onPressed: () {
            _postReply(request, widget.pk, _replyController.text);
          },
          child: const Text(
            "Submit",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: ListView.separated(
          itemCount: replies.length,
          separatorBuilder: (context, index) => SizedBox(
            height: 10,
          ),
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              child: Text(
                                  replies[index].createdBy![0].toUpperCase()),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(replies[index].createdBy ?? "")
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(replies[index].content!),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                    Text(replies[index].createdAt!)
                  ],
                ),
              ),
            );
          },
        ),
      )
    ];
  }

  List<Widget> buildLike(BuildContext context, List<Likes> likes) {
    return [
      Text("Likes (${likes.length})"),
      SizedBox(
        height: 20,
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: ListView.separated(
          itemCount: likes.length,
          separatorBuilder: (context, index) => SizedBox(
            height: 10,
          ),
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Text("T"),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text("@${likes[index].createdBy}")
                  ],
                ),
              ),
            );
          },
        ),
      )
    ];
  }
}
