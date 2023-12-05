import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class IndexScreenModel with ChangeNotifier {
  Future<void> clearProgressButtonClicked() async {
    Box box = await Hive.openBox('box');

    print('---------------------');
    print(box.get('box'));
    print('---------------------');
    await box.clear();
    print('------------2---------');
    print(box.get('box'));
    print('---------------------');
    notifyListeners();
  }
}
