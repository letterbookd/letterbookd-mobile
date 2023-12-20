// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:letterbookd/reader/models/reader.dart';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  bool shareLibrary = false;
  bool shareReviews = false;

  Future<String?> _getSavedUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('username');
  }

  Future<void> _saveProfile() async {
    String? username = await _getSavedUsername();

    if (username == null) {
      return;
    }

    var url = Uri.parse('${app_data.baseUrl}/reader/update-profile/');

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'username': username,
        'display_name': nameController.text,
        'bio': bioController.text,
        'share_reviews': shareReviews,
        'share_library': shareLibrary,
      }),
    );
    if (!context.mounted) return;

    // var requestData = {
    //   'username': username,
    //   'display_name': nameController.text,
    //   'bio': bioController.text,
    //   'share_reviews': shareReviews,
    //   'share_library': shareLibrary,
    // };

    // print("Sending data: $requestData");

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: ${response.body}')),
      );
    }
  }

  Future<void> fetchReaders() async {
    String? username = await _getSavedUsername();

    if (username != null) {
      var url = Uri.parse('${app_data.baseUrl}/reader/get-reader-json/');
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Username": username,
        },
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        debugPrint(jsonData.toString());
        var readerData = ReaderElement.fromJson(jsonData);
        debugPrint(readerData.preferences.shareLibrary.toString());
        setState(() {
          nameController.text = readerData.displayName ?? '';
          bioController.text = readerData.bio ?? '';
          shareLibrary = readerData.preferences.shareLibrary ?? false;
          shareReviews = readerData.preferences.shareReviews ?? false;
        });
      } else {
        throw Exception('Failed to load reader');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchReaders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextInputField('Name', 'Enter your name', nameController),
            _buildTextInputField('Bio', 'Write a short bio', bioController,
                maxLines: 5),
            SwitchListTile(
              title: const Text('Share Library'),
              value: shareLibrary,
              onChanged: (newValue) {
                setState(() => shareLibrary = !shareLibrary);
              },
            ),
            SwitchListTile(
              title: const Text('Share Reviews'),
              value: shareReviews,
              onChanged: (newValue) {
                setState(() => shareReviews = !shareReviews);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextInputField(
      String label, String hint, TextEditingController controller,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
