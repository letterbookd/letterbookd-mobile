// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:letterbookd/forum/models/thread.dart';
import 'package:letterbookd/forum/screens/add_forum.dart';
import 'package:letterbookd/forum/widgets/threadbox.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ForumHome extends StatelessWidget {
  const ForumHome({super.key});

  Future<List<Thread>> _fetchThread(CookieRequest request) async {
    try {
      final response = await request.get('http://10.0.2.2:8000/forum/json/');

      List<Thread> result = [];

      for (var i in response['threads']) {
        result.add(Thread.fromJson(i));
      }

      print(result);
      return result;
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
                  _buildThreadList(
                      snapshot.data!), // Placeholder for "Newest Threads"
                  _buildThreadList(
                      snapshot.data!), // Placeholder for "Popular Threads"
                ],
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddForumPage(),
            ));
          },
          child: const Icon(Icons.add),
          tooltip: 'Add New',
        ),
      ),
    );
  }

  Widget _buildThreadList(List<Thread> threads) {
    // Placeholder data, replace with your actual thread data

    return ListView.builder(
      itemCount: threads.length,
      itemBuilder: (context, index) {
        return ThreadBox(
          title: threads[index].fields!.title!,
          content: threads[index].fields!.content!,
        );
      },
    );
  }
}
