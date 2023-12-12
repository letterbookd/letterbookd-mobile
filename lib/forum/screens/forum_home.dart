// ignore_for_file: sort_child_properties_last, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:letterbookd/forum/models/thread.dart';
import 'package:letterbookd/forum/screens/add_edit_forum.dart';
import 'package:letterbookd/forum/screens/forum_detail.dart';
import 'package:letterbookd/forum/widgets/threadbox.dart';
import 'package:letterbookd/main.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ForumHome extends StatefulWidget {
  const ForumHome({super.key});

  @override
  State<ForumHome> createState() => _ForumHomeState();
}

class _ForumHomeState extends State<ForumHome> {
  Future<Map<String, List<Thread>>> _fetchThread(CookieRequest request) async {
    try {
      final response = await request.get('${AppData().url}/forum/json/');
      List<Thread> result = [];
      List<Thread> popularResult = [];
      for (var i in response['threads']) {
        result.add(Thread.fromJson(i));
      }

      for (var i in response['threads_by_like']) {
        popularResult.add(Thread.fromJson(i));
      }
      print(response);

      return {'newest': result, 'popular': popularResult};
    } catch (e) {
      throw Exception('error : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    CookieRequest request = context.watch<CookieRequest>();

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Forum"),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Newest Threads"),
              Tab(text: "Popular Threads"),
            ],
          ),
        ),
        body: FutureBuilder(
            future: _fetchThread(request),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return TabBarView(
                children: [
                  _buildThreadList(snapshot.data!['newest']!,
                      request), // Placeholder for "Newest Threads"
                  _buildThreadList(snapshot.data!['popular']!,
                      request), // Placeholder for "Popular Threads"
                ],
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddForumPage(
                isEdit: false,
              ),
            ));
          },
          child: const Icon(Icons.add),
          tooltip: 'Add New',
        ),
      ),
    );
  }

  Widget _buildThreadList(List<Thread> threads, CookieRequest request) {
    // Placeholder data, replace with your actual thread data

    return ListView.builder(
      itemCount: threads.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ForumDetailPage(
                createdAt: threads[index].fields!.createdAt!,
                threader: threads[index].fields!.createdBy!,
                pk: threads[index].pk!,
              ),
            ));
          },
          child: ThreadBox(
            title: threads[index].fields!.title!,
            content: threads[index].fields!.content!,
          ),
        );
      },
    );
  }
}
