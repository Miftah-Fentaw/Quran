import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkManager {
  static final BookmarkManager instance = BookmarkManager._internal();
  BookmarkManager._internal();

  final ValueNotifier<int?> bookmarkedPage = ValueNotifier<int?>(null);

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    int? page = prefs.getInt('bookmarkedPage');
    bookmarkedPage.value = page;
  }

  Future<void> setBookmark(int page) async {
    bookmarkedPage.value = page;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('bookmarkedPage', page);
  }

  Future<void> clearBookmark() async {
    bookmarkedPage.value = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('bookmarkedPage');
  }
}
