import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/screens/catalog_home.dart';
import 'package:letterbookd/forum/screens/forum_home.dart';
import 'package:letterbookd/library/screens/library_home.dart';
import 'package:letterbookd/reader/screens/reader_home.dart';
import 'package:letterbookd/review/screens/review_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  final List<Widget> _pages = [
    const LibraryHome(),
    const CatalogHome(),
    const ForumHome(),
    const ReviewHome(),
    const ReaderHome(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle getLabelStyle(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.selected,
      };
      if (states.any(interactiveStates.contains)) {
        return const TextStyle(fontWeight: FontWeight.bold);
      }
      return const TextStyle(fontWeight: FontWeight.normal);
    }

    return Scaffold(
      body: _pages[currentPageIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.resolveWith(getLabelStyle),
            indicatorColor: Theme.of(context).colorScheme.onPrimaryContainer),
        child: NavigationBar(
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.collections_bookmark),
              icon: Icon(Icons.collections_bookmark_outlined),
              label: 'Library',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.explore),
              icon: Icon(Icons.explore_outlined),
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
              label: 'Reviews',
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
        ),
      ),
    );
  }
}
