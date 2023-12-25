import 'package:flutter/material.dart';
import 'package:yasin_mulk_waqiya/screens/surah_list/surah_list_screens.dart';

class HomeScreenModel with ChangeNotifier {
  int currentIndex = 0;

  void onBottomNavigationTap(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<Widget> screensForBottomNav = [
    SurahListScreen(
      index: 0,
    ),
    SurahListScreen(
      index: 1,
    )
  ];
}
