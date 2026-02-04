// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:islamic/surah_pages.dart';
import 'package:islamic/surah_list.dart';
import 'package:islamic/theme_manager.dart';
import 'package:islamic/bookmark_manager.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gal/gal.dart';

class ReadQuran extends StatefulWidget {
  final int surahNumber;
  final String surahName;
  final int? initialPage;

  const ReadQuran({
    required this.surahNumber,
    required this.surahName,
    this.initialPage,
    super.key,
  });

  @override
  State<ReadQuran> createState() => _ReadQuranState();
}

class _ReadQuranState extends State<ReadQuran> {
  bool showPanel = false;
  late PageController pageController;
  int currentPageIndex = 0;
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    final startPage = widget.initialPage ?? surahPages[widget.surahNumber]![0];
    pageController = PageController(initialPage: startPage - 1);
    currentPageIndex = startPage - 1;
  }

  int getSurahNumberByPage(int page) {
    for (var entry in surahPages.entries) {
      if (page >= entry.value[0] && page <= entry.value[1]) {
        return entry.key;
      }
    }
    return 1;
  }

  Future<void> _takeScreenshot() async {
    final image = await screenshotController.capture();
    if (image != null) {
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/screenshot.png';
      final file = File(path);
      await file.writeAsBytes(image);

      try {
        await Gal.putImage(path);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Screenshot saved to gallery')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save screenshot: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ThemeManager.instance.isDarkMode,
      builder: (context, isDarkMode, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
            body: Stack(
              children: [
                Screenshot(
                  controller: screenshotController,
                  child: PageView.builder(
                    controller: pageController,
                    reverse: true,
                    itemCount: 604,
                    onPageChanged: (index) {
                      setState(() {
                        currentPageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            showPanel = !showPanel;
                          });
                        },
                        child: Stack(
                          children: [
                            SizedBox.expand(
                              child: Image.asset(
                                'assets/quran/${(index + 1).toString().padLeft(3, '0')}.webp',
                                color: isDarkMode ? Colors.white : null,
                                fit: BoxFit.fill,
                              ),
                            ),
                            ValueListenableBuilder<int?>(
                              valueListenable:
                                  BookmarkManager.instance.bookmarkedPage,
                              builder: (context, bookmarkedPage, child) {
                                if (bookmarkedPage == index + 1) {
                                  return Positioned(
                                    top: 20,
                                    right: 20,
                                    child: Icon(
                                      Icons.bookmark,
                                      color: Colors.amber.withOpacity(0.8),
                                      size: 40,
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  top: showPanel ? 20 : -60,
                  left: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.black.withOpacity(0.6)
                          : Colors.white.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),

                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  bottom: showPanel ? 0 : -100,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 70,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.black.withOpacity(0.8)
                          : Colors.white.withOpacity(0.9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(
                            isDarkMode ? Icons.light_mode : Icons.dark_mode,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          onPressed: () {
                            ThemeManager.instance.toggleTheme();
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.bookmark_add,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          onPressed: () {
                            BookmarkManager.instance.setBookmark(
                              currentPageIndex + 1,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Page bookmarked')),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          onPressed: _takeScreenshot,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.list_sharp,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              final surah = surahs.firstWhere(
                                (s) =>
                                    s.number ==
                                    getSurahNumberByPage(currentPageIndex + 1),
                              );
                              return Text(
                                "${surah.name} (${surah.arabic})",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
