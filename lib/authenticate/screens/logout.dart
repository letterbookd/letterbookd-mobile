import 'package:flutter/material.dart';
import 'package:letterbookd/authenticate/screens/login.dart';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;
import 'package:pbp_django_auth/pbp_django_auth.dart';

class Logout {
  static Future<void> performLogout(
      BuildContext context, CookieRequest request) async {
    var response = await request.get('${app_data.baseUrl}/auth/logout/');
    if (!context.mounted) return;

    if (response["status"]) {
      _showMessage(context, 'Sampai jumpa, $request["username"].');
      _navigateToLogin(context);
    } else {
      _showMessage(context, 'Logout gagal. Silakan coba lagi.');
    }
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
