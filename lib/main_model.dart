import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MainModel with ChangeNotifier {
  List favSurah = [];

  MainModel() {
    initBox();
  }

  initBox() async {
    var box = await Hive.openBox('box');
    box.add({"fav": []});
  }
}
