import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamic/Surah_list_screen.dart';
import 'package:islamic/about.dart';
import 'package:islamic/theme_manager.dart';
import 'package:islamic/bookmark_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ThemeManager.instance.init();
  await BookmarkManager.instance.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const QuranApp());
  });
}

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ThemeManager.instance.isDarkMode,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: isDarkMode ? Brightness.dark : Brightness.light,
          ),
          routes: {
            '/': (context) => const SurahListScreen(),
            '/about': (context) => const AboutPage(),
          },
        );
      },
    );
  }
}
