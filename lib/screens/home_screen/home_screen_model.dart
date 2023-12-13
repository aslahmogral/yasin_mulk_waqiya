import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreenModel with ChangeNotifier {
  Future<void> clearProgressButtonClicked() async {
    Box box = await Hive.openBox('box');
    await box.clear();
    notifyListeners();
  }
}
