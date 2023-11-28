import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/screens/catalog_all.dart';
import 'package:letterbookd/forum/screens/forum_home.dart';
import 'package:letterbookd/library/screens/library_display.dart';
import 'package:letterbookd/reader/screens/reader_page.dart';
import 'package:letterbookd/review/screens/review_home.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:letterbookd/core/widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  final List<Widget> _pages = [
    const LibraryDisplay(),
    const CatalogHomepage(),
    const ForumHomepage(),
    const ReviewHomepage(),
    const ReaderPage(),
  ];

  void _incrementCounter() {
    setState(() {
      currentPageIndex++;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentPageIndex], // TODO
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.all(
              Theme.of(context).textTheme.labelMedium),
        ),
        child: NavigationBar(
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
        ),
      ),
    );
  }
}
