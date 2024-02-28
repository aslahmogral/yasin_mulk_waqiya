import 'package:flutter/material.dart';

// Define a model class to represent Juz data
class JuzData {
  final double progress;
  final int currentPage;

  JuzData({required this.progress, required this.currentPage});
}

class JuzProgressProvider extends ChangeNotifier {
  // Global map to store Juz data
  late Map<int, JuzData> _globalJuzMap;

  // Constructor to initialize the global Juz map
  JuzProgressProvider() {
    _initializeJuzMap();
  }

  // Method to initialize the global Juz map
  void _initializeJuzMap() {
    _globalJuzMap = {
      for (int i = 1; i <= 30; i++) i: JuzData(progress: 0.0, currentPage: 0),
    };
  }

  // Method to update Juz progress
  void updateJuzProgress(int juzNumber, double progress, int currentPage) {
    if (_globalJuzMap.containsKey(juzNumber)) {
      _globalJuzMap[juzNumber] = JuzData(progress: progress, currentPage: currentPage);
      notifyListeners(); // Notify listeners about the data change
    }
  }

  // Method to get Juz progress
  double getJuzProgress(int juzNumber) {
    return _globalJuzMap.containsKey(juzNumber)
        ? _globalJuzMap[juzNumber]!.progress
        : 0.0;
  }

  // Method to get Juz current page
  int getJuzCurrentPage(int juzNumber) {
    return _globalJuzMap.containsKey(juzNumber)
        ? _globalJuzMap[juzNumber]!.currentPage
        : 0;
  }

  // Method to reset progress for all Juz
  void resetAllJuzProgress() {
    _initializeJuzMap(); // Reinitialize the map with default progress values
    notifyListeners();
  }

  // Method to reset progress for a selected Juz
  void resetSelectedJuzProgress(int juzNumber) {
    if (_globalJuzMap.containsKey(juzNumber)) {
      _globalJuzMap[juzNumber] = JuzData(progress: 0.0, currentPage: 0);
      notifyListeners();
    }
  }
}
