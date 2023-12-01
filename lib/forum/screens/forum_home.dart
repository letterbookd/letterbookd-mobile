// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:letterbookd/forum/widgets/threadbox.dart';

class ForumHome extends StatelessWidget {
  const ForumHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Forum"),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "All Threads"),
              Tab(text: "Newest Threads"),
              Tab(text: "Popular Threads"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildThreadList(),
            _buildThreadList(), // Placeholder for "Newest Threads"
            _buildThreadList(), // Placeholder for "Popular Threads"
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add action here
          },
          child: const Icon(Icons.add),
          tooltip: 'Add New',
        ),
      ),
    );
  }

  Widget _buildThreadList() {
    // Placeholder data, replace with your actual thread data
    List<Map<String, String>> threads = [
      {"title": "Thread 1", "content": "Content of Thread 1"},
      {"title": "Thread 2", "content": "Content of Thread 2"},
      // Add more threads as needed
    ];

    return ListView.builder(
      itemCount: threads.length,
      itemBuilder: (context, index) {
        return ThreadBox(
          title: threads[index]["title"]!,
          content: threads[index]["content"]!,
        );
      },
    );
  }
}
