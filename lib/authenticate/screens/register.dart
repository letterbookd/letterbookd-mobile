import 'package:letterbookd/authenticate/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Create a letterbookd account',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24.0),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Username',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              ),
            ),
            const SizedBox(height: 12.0),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Password',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              obscureText: _obscurePassword,
            ),
            const SizedBox(height: 12.0),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Confirm Password',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
              obscureText: _obscureConfirmPassword,
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  String username = _usernameController.text;
                  String password1 = _passwordController.text;
                  String password2 = _confirmPasswordController.text;

                  final response = await request.post(
                    '${app_data.baseUrl}/auth/register/',
                    {
                      'username': username,
                      'password1': password1,
                      'password2': password2,
                    },
                  );

                  if (!context.mounted) return;
                  if (response['status']) {
                    String message = response['message'];

                    // Navigate to Login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(content: Text(message)));
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Register failed.'),
                        content: Text(response['message']),
                        actions: [
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text(
                  'Sign up',
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                const SizedBox(width: 8.0),
                // Teks bukan tombol
                ElevatedButton(
                  onPressed: () async {
                    // Navigate to Login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text('Sign in'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
