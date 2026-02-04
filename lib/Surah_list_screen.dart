import 'package:flutter/material.dart';
import 'package:islamic/surah_list.dart';
import 'package:islamic/Reading_Screen.dart';

import 'package:islamic/theme_manager.dart';
import 'package:islamic/bookmark_manager.dart';
import 'package:islamic/surah_pages.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ThemeManager.instance.isDarkMode,
      builder: (context, isDarkMode, child) {
        return Scaffold(
          backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            foregroundColor: isDarkMode ? Colors.white : Colors.black,
            title: const Text('Quran'),
            backgroundColor: isDarkMode
                ? const Color(0xFF121212)
                : Colors.white,
            centerTitle: true,
            actions: [
              ValueListenableBuilder<int?>(
                valueListenable: BookmarkManager.instance.bookmarkedPage,
                builder: (context, bookmarkedPage, child) {
                  if (bookmarkedPage == null) return const SizedBox.shrink();
                  return IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReadQuran(
                            surahNumber:
                                1, // Will be updated by page index logic
                            surahName: "Last Read",
                            initialPage: bookmarkedPage,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.bookmark, color: Colors.amber),
                  );
                },
              ),
              IconButton(
                onPressed: () {
                  ThemeManager.instance.toggleTheme();
                },
                icon: Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
            actionsPadding: const EdgeInsets.only(left: 10),
          ),
          body: ListView.separated(
            padding: const EdgeInsets.all(12),
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemCount: surahs.length,
            itemBuilder: (context, index) {
              final surah = surahs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReadQuran(
                        surahNumber: surah.number,
                        surahName: surah.name,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isDarkMode
                          ? Colors.grey.shade800
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                          image: const DecorationImage(
                            image: AssetImage('assets/image.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Text(
                          surah.number.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDarkMode
                                ? Colors.amber.shade200
                                : const Color(0xff8B6B00),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              surah.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              "(${surah.translation})",
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.grey.shade400
                                    : Colors.black54,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "${surah.type} • ${surah.verses} Verses",
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.grey.shade500
                                    : Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ValueListenableBuilder<int?>(
                        valueListenable:
                            BookmarkManager.instance.bookmarkedPage,
                        builder: (context, bookmarkedPage, child) {
                          if (bookmarkedPage != null) {
                            final range = surahPages[surah.number];
                            if (range != null &&
                                bookmarkedPage >= range[0] &&
                                bookmarkedPage <= range[1]) {
                              return const Icon(
                                Icons.bookmark,
                                color: Colors.amber,
                                size: 20,
                              );
                            }
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      Text(
                        surah.arabic,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Amiri',
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
