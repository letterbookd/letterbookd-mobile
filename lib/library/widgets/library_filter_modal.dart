import 'package:flutter/material.dart';

class LibraryFilterModal extends StatefulWidget {
  const LibraryFilterModal({super.key});

  @override
  State<LibraryFilterModal> createState() => _LibraryFilterModalState();
}

class _LibraryFilterModalState extends State<LibraryFilterModal>
    with SingleTickerProviderStateMixin {
  static const List<Tab> modalTabs = <Tab>[
    Tab(
      text: "Sort",
    ),
    Tab(
      text: "Filter",
    ),
    Tab(
      text: "Display",
    ),
  ];

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 335,
              child: DefaultTabController(
                length: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TabBar(
                          labelStyle: Theme.of(context).textTheme.bodyLarge,
                          controller: _controller,
                          tabs: modalTabs,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _controller,
                            children: <Widget>[
                              SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.sort_by_alpha),
                                      title: const Text('Ttile'),
                                      onTap: () {
                                        Navigator.pop(context, 'title');
                                      },
                                    ),
                                    ListTile(
                                      leading:
                                          const Icon(Icons.schedule_rounded),
                                      title: const Text('Recently Added'),
                                      onTap: () {
                                        Navigator.pop(context, 'recentlyAdded');
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.label_outline),
                                      title: const Text('Tracking Status'),
                                      onTap: () {
                                        Navigator.pop(
                                            context, 'trackingStatus');
                                      },
                                    ),
                                    const Divider(),
                                    ListTile(
                                      leading: const Icon(Icons.arrow_upward),
                                      title: const Text('Sort Ascending'),
                                      onTap: () {
                                        Navigator.pop(context, 'ascending');
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.arrow_downward),
                                      title: const Text('Sort Descending'),
                                      onTap: () {
                                        Navigator.pop(context, 'descending');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(
                                          Icons.align_horizontal_left_sharp),
                                      title: const Text('All'),
                                      onTap: () {
                                        Navigator.pop(context, 'all');
                                      },
                                    ),
                                    ListTile(
                                      leading:
                                          const Icon(Icons.favorite_outline),
                                      title: const Text('Favorites'),
                                      onTap: () {
                                        Navigator.pop(context, 'favorites');
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.done_all),
                                      title: const Text('Finished Reading'),
                                      onTap: () {
                                        Navigator.pop(context, 'finished');
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.done),
                                      title: const Text('Currently Reading'),
                                      onTap: () {
                                        Navigator.pop(context, 'reading');
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.pause_outlined),
                                      title: const Text('On Hold'),
                                      onTap: () {
                                        Navigator.pop(context, 'onHold');
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.calendar_month),
                                      title: const Text('Planning to Read'),
                                      onTap: () {
                                        Navigator.pop(context, 'planned');
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.close),
                                      title: const Text('Dropped'),
                                      onTap: () {
                                        Navigator.pop(context, 'dropped');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  ListTile(
                                    leading:
                                        const Icon(Icons.grid_view_outlined),
                                    title: const Text('Grid View'),
                                    onTap: () {
                                      Navigator.pop(context, 'grid');
                                    },
                                  ),
                                  ListTile(
                                    leading:
                                        const Icon(Icons.view_list_outlined),
                                    title: const Text('List View'),
                                    onTap: () {
                                      Navigator.pop(context, 'list');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              ));
        }),
      ),
    );
  }
}
