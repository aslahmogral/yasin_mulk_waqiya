import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:yasin_mulk_waqiya/screens/surah_screen/surah_screen.dart';

class surahListTieModel with ChangeNotifier {
  String status = '';
  var currentAyah = 0;
  late Box box;
  late Box surahbox;
  late int surahNumber;
  surahListTieModel(int surahNumber) {
    this.surahNumber = surahNumber;
    initBox(surahNumber);
  }

  initBox(int surahNumber) async {
    box = await Hive.openBox('box');

    if (box.isEmpty) {
      print('empty');
    } else {
      var prevBox = await box.get(surahNumber);

      if (prevBox != null) {
        status = prevBox['status'];
        currentAyah = prevBox['currentAyah'];
        // DateTime savedDate = prevBox['date'];
        // if (DateTime.now() != savedDate) {
        //   clearProgressButtonClicked();
        // }

        // print(prevBox);
      }
    }

    notifyListeners();

    // setState(() {});
  }

  Future<void> clearProgressButtonClicked() async {
    Box box = await Hive.openBox('box');
    print(box.get('box'));
    await box.clear();
    print(box.get('box'));
    notifyListeners();
  }

  Future<void> onListTileClicked(
      BuildContext context, surahListTieModel model) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SurahWidget(
            surahNumber: model.surahNumber,
            previousVerse: model.currentAyah,
          ),
        ));

    status = result['status'];
    if (status != "completed") {
      currentAyah = result['currentAyah'];
      box.put(model.surahNumber, {
        'currentAyah': currentAyah,
        'status': status,
        'date': result['date']
      });
    }
    // });
    notifyListeners();
  }
}
