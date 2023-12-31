import 'package:daily_quran/screens/surah_tile/surah_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
    // switchSurahList(index);
  }

  initDailySurahs() {
    isSurahLoading = true;
    notifyListeners();
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
    isSurahLoading = false;

    notifyListeners();
  }

  switchSurahList(int index) async {
    isSurahLoading = true;
    notifyListeners();
    if (index == 0) {
      finalList.clear();
      finalList = favoriteSurahList;
      // notifyListeners();
    } else {
      finalList.clear();

      finalList = dailySurahList;
      // notifyListeners();
    }
    isSurahLoading = false;
    notifyListeners();
  }
}
