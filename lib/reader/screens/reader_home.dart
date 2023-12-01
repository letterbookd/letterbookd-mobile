import 'package:flutter/material.dart';
import 'package:letterbookd/reader/screens/reader_settings.dart';

class ReaderHome extends StatelessWidget {
  const ReaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final reader = {
      'username': 'letter',
      'name': 'letterbookd',
      'bio': 'Loves reading fantasy novels',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reader"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/pfp_0.jpg'),
              ),
            ),
            _buildUserInfoCard('Username', reader['username']!),
            _buildUserInfoCard('Name', reader['name']!),
            _buildUserInfoCard('Bio', reader['bio']!),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditProfileScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Background color
                onPrimary: Colors.white, // Text color
              ),
              child: const Text('Edit Profile'),
            ),
            SizedBox(height: 24),
            const Text(
              'Library',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            _buildGridSection(4), // Library cards
            SizedBox(height: 24),
            const Text(
              'Review',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            _buildGridSection(4), // Review cards
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoCard(String title, String content) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(content),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      ),
    );
  }

  Widget _buildGridSection(int itemCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 4,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Card(
          child: Container(),
        );
      },
    );
  }
}
