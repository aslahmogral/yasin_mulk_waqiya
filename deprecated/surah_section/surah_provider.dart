import 'surah_card/surah_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define a model class to represent surah data
class SurahData {
  final double progress;
  final int currentPage;

  SurahData({required this.progress, required this.currentPage});
}

class SurahProgressProvider extends ChangeNotifier {
  late Map<int, SurahData> _globalSurahMap;
  late SharedPreferences _prefsSurah;
  List<surahCard> surahList = List.generate(
    114 ,
    (index) => surahCard(
      surahNumber: index + 1,
    ),
  );

  bool shouldReset = false;

  void updateShouldReset(bool value) {
    shouldReset = value;
    notifyListeners();
  }

  SurahProgressProvider() {
    _initializeSurahMap();
    _initSharedPreferences();
  }

  void _initializeSurahMap() {
    _globalSurahMap = {
      for (int i = 1; i <= 114; i++)
        i: SurahData(progress: 0.0, currentPage: 0),
    };
  }

  void _initSharedPreferences() async {
    _prefsSurah = await SharedPreferences.getInstance();
    _loadSurahProgressFromStorage();
  }

  void _saveSurahProgressToStorage(
      int surahNumber, double progress, int currentPage) {
    _prefsSurah.setDouble('surah_$surahNumber' '_progress', progress);
    _prefsSurah.setInt('surah_$surahNumber' '_currentPage', currentPage);
  }

  void _loadSurahProgressFromStorage() {
    for (int i = 1; i <= 30; i++) {
      double progress = _prefsSurah.getDouble('surah_$i' '_progress') ?? 0.0;
      int currentPage = _prefsSurah.getInt('surah_$i' '_currentPage') ?? 0;
      _globalSurahMap[i] =
          SurahData(progress: progress, currentPage: currentPage);
    }
    notifyListeners();
  }

  void updateSurahProgress(int surahNumber, double progress, int currentPage) {
    if (_globalSurahMap.containsKey(surahNumber)) {
      _globalSurahMap[surahNumber] =
          SurahData(progress: progress, currentPage: currentPage);
      _saveSurahProgressToStorage(surahNumber, progress, currentPage);
      notifyListeners();
    }
  }

  double getSurahProgress(int surahNumber) {
    return _globalSurahMap.containsKey(surahNumber)
        ? _globalSurahMap[surahNumber]!.progress
        : 0.0;
  }

  int getSurahCurrentPage(int surahNumber) {
    return _globalSurahMap.containsKey(surahNumber)
        ? _globalSurahMap[surahNumber]!.currentPage
        : 0;
  }

  void resetAllSurahProgress() {
    _initializeSurahMap();
    _prefsSurah.clear(); // Clear SharedPreferences to reset the saved data
    notifyListeners();
  }

  void resetSelectedSurahProgress(int surahNumber) {
    if (_globalSurahMap.containsKey(surahNumber)) {
      _globalSurahMap[surahNumber] = SurahData(progress: 0.0, currentPage: 0);
      _saveSurahProgressToStorage(
          surahNumber, 0.0, 0); // Save reset progress to SharedPreferences
      notifyListeners();
    }
  }
}
