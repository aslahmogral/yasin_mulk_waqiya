import 'package:daily_quran/screens/surah_list/all_surah_list.dart';
import 'package:daily_quran/screens/surah_list/fav_surah_list.dart';
import 'package:flutter/material.dart';

class HomeScreenModel with ChangeNotifier {
  int currentIndex = 0;

  void onBottomNavigationTap(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<Widget> screensForBottomNav = [SurahListScreen(), AllSurahListScreen()];
}
