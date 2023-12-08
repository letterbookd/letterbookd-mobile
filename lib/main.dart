import 'package:flutter/material.dart';
import 'package:letterbookd/authenticate/screens/login.dart';
import 'package:letterbookd/forum/screens/forum_home.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:letterbookd/core/screens/homepage.dart';

void main() {
  runApp(const App());
}

/// Data konstanta untuk aplikasi
class AppData {
  final Color seedColor = Colors.blue;
  final String url = "http://10.0.2.2:8000";
  final double bookAspectRatio = 181 / 291;
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
        themeMode: ThemeMode.system,
        home: const LoginPage(),
      ),
    );
  }
}
