import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentPageIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.collections_bookmark),
          icon: Icon(Icons.collections_bookmark_outlined),
          label: 'Library',
        ),
        NavigationDestination(
          icon: Icon(Icons.shelves),
          label: 'Catalog',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.forum),
          icon: Icon(Icons.forum_outlined),
          label: 'Forum',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.reviews),
          icon: Icon(Icons.reviews_outlined),
          label: 'Review',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.account_circle),
          icon: Icon(Icons.account_circle_outlined),
          label: 'You',
        ),
      ],
      indicatorColor: Theme.of(context).colorScheme.inversePrimary,
      selectedIndex: currentPageIndex,
      onDestinationSelected: _onItemTapped,
    );
  }
}
