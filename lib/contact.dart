import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  void _launchPhone(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _launchEmail(String email) async {
    final Uri url = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

 Future<void> _launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  try {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlString';
    }
  } catch (e) {
    debugPrint("Launch error: $e");
  }
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Contact'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Card(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.phone, color: Colors.green),
                title: const Text('Phone'),
                subtitle: const Text('+251 956291689'),
                onTap: () => _launchPhone('+251956291689'),
              ),
            ),
            Card(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.email, color: Colors.green),
                title: const Text('Email'),
                subtitle: const Text('HudaAlIslamorg@gmail.com'),
                onTap: () => _launchEmail('HudaAlIslamorg@gmail.com'),
              ),
            ),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Social Media',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.telegram, color: Colors.blue),
                          onPressed: () => _launchURL('https://www.t.me/Mance_1'),
                        ),
                        IconButton(
                          icon: const Icon(CupertinoIcons.link_circle, color: Colors.blueAccent),
                          onPressed: () => _launchURL('https://www.linkedin.com/in/miftah-fentaw'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.message, color: Colors.purple),
                          onPressed: () => _launchURL('https://instagram.com/miftah_fentaw16'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
