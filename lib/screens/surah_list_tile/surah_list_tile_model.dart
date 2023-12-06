import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:yasin_mulk_waqiya/model/surahmodel.dart';
import 'package:yasin_mulk_waqiya/screens/surah_screen/surah_screen.dart';

class surahListTieModel with ChangeNotifier {
  String progressOfSurah = '';
  var previousVerse = 0;
  late Box box;
  late Box surahbox;
  late int surahNumber ;
  surahListTieModel(int surahNumber) {
    this.surahNumber = surahNumber;
    initBox(surahNumber);
  }

  initBox(int surahNumber) async {
    box = await Hive.openBox('box');
  
    if (box.isEmpty ) {
      print('empty');
      // await box.put(widget.surahNumber ,{"progress" : null,"previousVerse" : null});
    } else {
      var prev = await box.get(surahNumber);

      if (prev != null) {
        progressOfSurah = prev['progress'];
        previousVerse = prev['previousVerse'];
        print(prev);
      }
      // await box.put(widget.surahNumber, {'progress', 'previousVerse'});
    }

    //////>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    surahbox = await Hive.openBox<SurahModel>('surahBox');
    
     if (surahbox.isEmpty ) {
      print('empty');
      // await box.put(widget.surahNumber ,{"progress" : null,"previousVerse" : null});
    } else {
      SurahModel prev = await surahbox.get(surahNumber);

      if (prev != null) {
        progressOfSurah = prev.currentAyah.toString();
        previousVerse = prev.currentAyah;
        print(prev);
      }
      // await box.put(widget.surahNumber, {'progress', 'previousVerse'});
    }
    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


    notifyListeners();

    // setState(() {});
  }

  Future<void> onListTileClicked(
      BuildContext context, surahListTieModel model) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SurahWidget(
            surahNumber: model.surahNumber,
            previousVerse: model.previousVerse,
          ),
        ));

    // setState(() {
    progressOfSurah = result['type'];
    if (progressOfSurah != "completed") {
      previousVerse = result['verses'];
      box.put(model.surahNumber,
          {'previousVerse': previousVerse, 'progress': progressOfSurah});
    }
    // });
    notifyListeners();
  }

  
}
