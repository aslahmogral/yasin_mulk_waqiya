import 'dart:convert';

import 'package:daily_quran/model/ayah.dart';
import 'package:daily_quran/model/juz_data.dart';
import 'package:daily_quran/model/surah.dart';
import 'package:daily_quran/widgets/juz_card/juz_card.dart';
import 'package:flutter/material.dart';
import 'package:jhijri/_src/_jHijri.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeScreenModel extends ChangeNotifier {
  final jHijri = JHijri(fDate: DateTime.now());
  late Map<int, JuzProgress> _globalJuzMap;
  late SharedPreferences _prefs;
  String currentMonthYearKey = '${JHijri.now().year},${JHijri.now().month}';
  var year = JHijri.now().year;
  int month = JHijri.now().month;
  // String currentMonthYear = '${JHijri.now().year},${JHijri.now().monthName}, ${JHijri.now().day}';

  List ayahs = [];
  List juzs = [];
  List surahs = [];
  List<JuzCard> juzList = List.generate(
    30,
    (index) => JuzCard(
      juzNumber: index + 1,
    ),
  );
  bool shouldReset = false;

  void updateShouldReset(bool value) {
    shouldReset = value;
    notifyListeners();
  }

  HomeScreenModel() {
    getAyahs();
    _initializeJuzMap();
    _initSharedPreferences();
  }

  prevMonthYear() {
    month--;
    if (month == 0) {
      year--;
      month = 12;
    }
    currentMonthYearKey = '$year,$month';
    // currentMonthYear = '${year},${JHijri(fMonth:  month).monthName}';

    notifyListeners();
    _loadJuzProgressFromStorage();
  }

  nextMonthYear() {
    if (currentMonthYearKey == '${JHijri.now().year},${JHijri.now().month}') {
      return;
    }
    month++;
    if (month == 13) {
      year++;
      month = 1;
    }
    currentMonthYearKey = '$year,$month';
    // currentMonthYear = '${year},${JHijri(fMonth:  month).monthName}';

    notifyListeners();
    _loadJuzProgressFromStorage();
  }

  Future<void> getQuranTranslations(int juz) async {
    var url = Uri.parse(
        // 'https://api.quran.com/api/v4/verses/by_juz/$juz?language=en&words=true&translations=true');
        // /verses/by_juz/$juzNumber"
        'https://api.quran.com/api/v4/quran/verses/uthmani?juz_number=$juz');

        // https://api.quran.com/api/v4/verses/by_juz/:juz_number'

    var response = await http.get(url, headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      juzs.add(List<Ayah>.from(
          jsonResponse['verses'].map((ayah) => Ayah.fromJson(ayah))));
      print('Quran verses retrieved successfully.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void getAyahs() async {
    for (int i = 1; i <= 30; i++) {
      await getQuranTranslations(i);
    }
    ayahs = juzs.expand((element) => element).toList();
    for(int i = 1; i <= 114; i++){
      List element = ayahs.where((ayah) => ayah.verseKey.split(':')[0] == i.toString()).toList();
      surahs.add(Surah(surahNumber: i, ayahs: element));
    }
  }

  void _initializeJuzMap() {
    _globalJuzMap = {
      for (int i = 1; i <= 30; i++)
        i: JuzProgress(progress: 0.0, currentPage: 0),
    };
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadJuzProgressFromStorage();
  }

  // void _loadJuzProgressFromStorage() {
  //   for (int i = 1; i <= 30; i++) {
  //     double progress = _prefs.getDouble('juz_${i}_progress') ?? 0.0;
  //     int currentPage = _prefs.getInt('juz_${i}_currentPage') ?? 0;
  //     _globalJuzMap[i] = JuzData(progress: progress, currentPage: currentPage);
  //   }
  // }

  // void _saveJuzProgressToStorage(int juzNumber, double progress, int currentPage) {
  //   _prefs.setDouble('juz_${juzNumber}_progress', progress);
  //   _prefs.setInt('juz_${juzNumber}_currentPage', currentPage);
  // }

  void _saveJuzProgressToStorage(
      int juzNumber, double progress, int currentPage) {
    // _prefs.clear();
    // _prefs.setDouble('juz_$juzNumber' '_progress', progress);
    // _prefs.setInt('juz_$juzNumber' '_currentPage', currentPage);
    var juzp = jsonEncode(_globalJuzMap.map((key, value) => MapEntry(
        key.toString(),
        {'progress': value.progress, 'currentPage': value.currentPage})));
    _prefs.setString(currentMonthYearKey, juzp);
  }

  void _loadJuzProgressFromStorage() {
    var juzp = _prefs.getString(currentMonthYearKey);
    if (juzp == null) {
      var juzptemp = jsonEncode(_globalJuzMap.map((key, value) => MapEntry(
          key.toString(),
          {'progress': value.progress, 'currentPage': value.currentPage})));
      _prefs.setString(currentMonthYearKey, juzptemp);
      juzp = _prefs.getString(currentMonthYearKey);
    }
    var pro = jsonDecode(juzp!);

    for (int i = 1; i <= 30; i++) {
      double progress = pro[i.toString()]['progress'] ?? 0.0;
      int currentPage = pro[i.toString()]['currentPage'] ?? 0;
      _globalJuzMap[i] =
          JuzProgress(progress: progress, currentPage: currentPage);
    }

    notifyListeners();
  }

  void updateJuzProgress(int juzNumber, double progress, int currentPage) {
    if (_globalJuzMap.containsKey(juzNumber)) {
      _globalJuzMap[juzNumber] =
          JuzProgress(progress: progress, currentPage: currentPage);
      _saveJuzProgressToStorage(juzNumber, progress, currentPage);
      notifyListeners();
    }
  }

  double getJuzProgress(int juzNumber) {
    return _globalJuzMap.containsKey(juzNumber)
        ? _globalJuzMap[juzNumber]!.progress
        : 0.0;
  }

  int getJuzCurrentPage(int juzNumber) {
    return _globalJuzMap.containsKey(juzNumber)
        ? _globalJuzMap[juzNumber]!.currentPage
        : 0;
  }

  void resetAllJuzProgress() {
    _initializeJuzMap();
    _prefs.clear(); // Clear SharedPreferences to reset the saved data
    notifyListeners();
  }

  void resetSelectedJuzProgress(int juzNumber) {
    if (_globalJuzMap.containsKey(juzNumber)) {
      _globalJuzMap[juzNumber] = JuzProgress(progress: 0.0, currentPage: 0);
      _saveJuzProgressToStorage(
          juzNumber, 0.0, 0); // Save reset progress to SharedPreferences
      notifyListeners();
    }
  }
}
