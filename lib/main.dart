import 'package:flutter/material.dart';
import 'package:islamic/HomePage.dart';
import 'package:islamic/Surah_list_screen.dart';
import 'package:islamic/about.dart';
import 'package:islamic/contact.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(QuranApp());
  });
}

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/List': (context) => const SurahListScreen(),
        '/contact': (context) => const ContactPage(),
        '/about': (context) => const AboutPage(),
      },
      home: const HomePage(),
    );
  }
}
