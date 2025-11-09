import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('About'),
        backgroundColor: isDarkMode ? Colors.black : Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
              color: isDarkMode ? Colors.grey[900] : Colors.white,
              child: ListTile(
                leading: const Icon(Icons.info, color: Colors.green),
                title: const Text('App Version'),
                subtitle: const Text('v1.0.0'),
              ),
            ),
            Card(
              color: isDarkMode ? Colors.grey[900] : Colors.white,
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.green),
                title: const Text('Developer'),
                subtitle: const Text('HUDA AL-ISLAM'),
              ),
            ),
            Card(
              color: isDarkMode ? Colors.grey[900] : Colors.white,
              child: ListTile(
                leading: const Icon(Icons.book, color: Colors.green),
                title: const Text('Quran Source'),
                subtitle: const Text('Standard Uthmani Script, Offline'),
              ),
            ),
            Card(
              color: isDarkMode ? Colors.grey[900] : Colors.white,
              child: ListTile(
                leading: const Icon(Icons.privacy_tip, color: Colors.green),
                title: const Text('Privacy Policy'),
                subtitle: const Text('This App is Fully Offline and No Personal Data is Being Colleced.'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '“Read the Quran with reflection and understanding.”',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
