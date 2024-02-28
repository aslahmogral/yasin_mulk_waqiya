import 'package:flutter/material.dart';

class JuzProgressProvider extends ChangeNotifier {
  // Global map to store Juz data
  Map<int, double> _globalJuzMap = {
    for (int i = 1; i <= 30; i++) i: 0.0,
  };

  // Method to update Juz
  void updateJuzData(int juzNumber, double progress) {
    if (_globalJuzMap.containsKey(juzNumber)) {
      _globalJuzMap[juzNumber] = progress;
      notifyListeners(); // Notify listeners about the data change
    }
  }

  // Method to get Juz data
  double getJuzData(int juzNumber) {
    return _globalJuzMap.containsKey(juzNumber)
        ? _globalJuzMap[juzNumber]!
        : 0.0;
  }

  void resetAllJuzProgress() {
    _globalJuzMap = {
      for (int i = 1; i <= 30; i++) i: 0.0,
    };
    notifyListeners();
  }

  void resetSelectedJuzProgress(int juzNumber) {
    if (_globalJuzMap.containsKey(juzNumber)) {
      _globalJuzMap[juzNumber] = 0.0;
      notifyListeners();
    }
  }
}
