import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:letterbookd/core/widgets/bottom_navbar.dart';
import 'package:letterbookd/core/screens/homepage.dart';

void main() {
  runApp(const App());
}

/// Data konstanta untuk aplikasi
class AppData {
  final seedColor = Colors.blue;
  final url = "https://letterbookd-a09-tk.pbp.cs.ui.ac.id/";
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'letterbookd',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor: AppData().seedColor),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
              seedColor: AppData().seedColor, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.dark,
        home: const HomePage(),
      ),
    );
  }
}
