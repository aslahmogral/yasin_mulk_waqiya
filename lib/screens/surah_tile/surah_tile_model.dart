import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:yasin_mulk_waqiya/screens/surah_screen/surah_screen.dart';

class surahTileModel with ChangeNotifier {
  String status = 'Read';
  var currentAyah = 0;
  late Box box;
  late Box surahbox;
  late int surahNumber;
  late String boxName;

  surahTileModel(int surahNumber, String boxName) {
    this.surahNumber = surahNumber;
    this.boxName = boxName;
    initBox(surahNumber);
  }

  initBox(int surahNumber) async {
    box = await Hive.openBox(boxName);

    if (box.isNotEmpty) {
      var prevBox = await box.get(surahNumber);

      if (prevBox != null) {
        status = prevBox['status'];
        currentAyah = prevBox['currentAyah'];

        DateTime savedDate = prevBox['date'];
        if (DateTime.now().day != savedDate.day &&
            DateTime.now().month != savedDate.month) {
          status = 'Read';
          box.put(surahNumber, {'currentAyah': 0, 'status': "Read"});
        }

        print(prevBox);
      }
    }

    notifyListeners();

    // setState(() {});
  }

  Future<void> clearProgressButtonClicked() async {
    Box box = await Hive.openBox(boxName);
    await box.clear();
    notifyListeners();
  }

  Future<void> onListTileClicked(
      BuildContext context, surahTileModel model) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SurahWidget(
            surahNumber: model.surahNumber,
            previousVerse: model.currentAyah,
          ),
        ));

    if (result != null) {
      status = result['status'];
      if (status != "completed") {
        currentAyah = result['currentAyah'];
        box.put(model.surahNumber, {
          'currentAyah': currentAyah,
          'status': status,
          'date': result['date']
        });
      } else {
        box.put(model.surahNumber,
            {'currentAyah': 0, 'status': status, 'date': DateTime.now()});
      }
    }

    // });
    notifyListeners();
  }
}
