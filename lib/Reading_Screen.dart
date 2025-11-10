import 'package:flutter/material.dart';
import 'package:islamic/surah_pages.dart';
import 'package:islamic/surah_list.dart';

class ReadQuran extends StatefulWidget {
  final int surahNumber;
  final String surahName;

  const ReadQuran({
    required this.surahNumber,
    required this.surahName,
    super.key,
  });

  @override
  State<ReadQuran> createState() => _ReadQuranState();
}

class _ReadQuranState extends State<ReadQuran> {
  bool isDarkMode = true;
  bool showPanel = false;
  late PageController pageController;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    final startPage = surahPages[widget.surahNumber]![0];
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        body: Stack(
          children: [
            PageView.builder(
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
                  child: SizedBox.expand(
                    child: Image.asset(
                      'assets/quran/${(index + 1).toString().padLeft(3, '0')}.webp',
                      color: isDarkMode ? Colors.white : null,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
      
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              bottom: showPanel ? 0 : -80,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                color: isDarkMode
                    ? Colors.grey.withOpacity(0.7)
                    : Colors.black.withOpacity(0.7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.brightness_6,
                        color: isDarkMode ? Colors.black : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          isDarkMode = !isDarkMode;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.list_sharp,
                        color: isDarkMode ? Colors.black : Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      surahs.firstWhere(
                        (s) =>
                            s.number == getSurahNumberByPage(currentPageIndex + 1),
                      ).name +'(' +surahs.firstWhere(
                        (s) =>
                            s.number == getSurahNumberByPage(currentPageIndex + 1),
                      ).arabic + ')',
                      style: TextStyle(
                          color: isDarkMode ? Colors.black : Colors.white70,
                          fontWeight: FontWeight.bold),
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
