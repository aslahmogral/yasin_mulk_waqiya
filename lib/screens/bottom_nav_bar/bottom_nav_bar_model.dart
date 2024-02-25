import 'package:daily_quran/screens/surah_index_screen/all_surah_index_screen.dart';
import 'package:daily_quran/screens/surah_index_screen/fav_surah_index_screen.dart';
import 'package:flutter/material.dart';

class HomeScreenModel with ChangeNotifier {
  int currentIndex = 0;

  void onBottomNavigationTap(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<Widget> screensForBottomNav = [SurahListScreen(), AllSurahListScreen()];
}
