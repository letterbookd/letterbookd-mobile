import 'package:flutter/material.dart';
import 'package:letterbookd/catalog/screens/librarian_catalog.dart';
import 'package:letterbookd/catalog/screens/librarian_profile.dart';

class LibrarianHomePage extends StatefulWidget {
  const LibrarianHomePage({super.key});

  @override
  State<LibrarianHomePage> createState() => _LibrarianHomePageState();
}

class _LibrarianHomePageState extends State<LibrarianHomePage> {
  int currentPageIndex = 0;
  final List<Widget> _pages = [
    const LibrarianCatalog(),
    const LibrarianProfile()
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
              selectedIcon: Icon(Icons.menu_book_outlined),
              icon: Icon(Icons.menu_book_sharp),
              label: 'Catalog',
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
