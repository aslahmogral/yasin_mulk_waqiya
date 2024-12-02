import 'package:daily_quran/juz_screen/juz_screen.dart';
// import 'package:daily_quran/references/screens/surah_screen/surah_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class juzCardModel with ChangeNotifier {
  String status = 'Read';
  var currentAyah = 0;
  late Box box;
  // late Box surahbox;
  late int juzNumber;
  // late String boxName;
  bool shouldReset = false;

  juzCardModel(
    int surahNumber,
  ) {
    this.juzNumber = surahNumber;
    // this.boxName = boxName;
    // initBox(surahNumber);
  }

  void updateShouldReset(bool value) {
    shouldReset = value;
    notifyListeners();
  }

  Future<void> onListTileClicked(
      BuildContext context, juzCardModel model) async {
    // var result = await
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JuzScreen(
            juzNumber: juzNumber,
          ),
        ));

    notifyListeners();
  }
}
