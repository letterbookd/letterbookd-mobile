// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:letterbookd/authenticate/screens/login.dart';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;
import 'package:shared_preferences/shared_preferences.dart';

class Logout {
  static Future<void> performLogout(BuildContext context) async {
    String? username = await _getSavedUsername();
    if (username == null) {
      _showMessage(context, 'Kamu sudah logout atau belum masuk.');
      _navigateToLogin(context);
      return;
    }

    var url = Uri.parse('${app_data.baseUrl}/auth/logout/');
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      _showMessage(context, 'Sampai jumpa, $username.');
      _navigateToLogin(context);
    } else {
      _showMessage(context, 'Logout gagal. Silakan coba lagi.');
    }
  }

  static Future<String?> _getSavedUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  static void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  static void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
