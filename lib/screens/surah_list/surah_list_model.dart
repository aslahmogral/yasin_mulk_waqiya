import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:yasin_mulk_waqiya/screens/surah_tile/surah_tile.dart';

class SurahListModel with ChangeNotifier {
  List<Widget> dailySurahList = [];
  List favSurahNumberList = [36, 67, 56, 18];
  List<Widget> favoriteSurahList = [];
  bool isSurahLoading = false;
  // var index;
  List<Widget> finalList = [];
  Future<void> clearProgressButtonClicked() async {
    Box box = await Hive.openBox('box');
    await box.clear();
    notifyListeners();
  }

  SurahListModel() {
    // this.index = index;
    initDailySurahs();
  }

  initDailySurahs() {
    for (int i = 0; i < favSurahNumberList.length; i++) {
      favoriteSurahList.add(
        SurahTile(
          boxName: 'box',
          surahNumber: favSurahNumberList[i],
        ),
      );
    }
    for (int i = 1; i <= 114; i++) {
      dailySurahList.add(
        SurahTile(
          boxName: 'box',
          surahNumber: i,
        ),
      );
    }
    // switchSurahList();
    notifyListeners();
  }

  switchSurahList(int index) {
    isSurahLoading = true;
    if (index == 0) {
      finalList = favoriteSurahList;
      // notifyListeners();
    } else {
      finalList = dailySurahList;
      // notifyListeners();
    }
    isSurahLoading = false;
  }
}
