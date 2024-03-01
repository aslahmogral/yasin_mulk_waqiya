import 'package:daily_quran/juz_section/juz_screen/juz_screen.dart';
import 'package:daily_quran/references/screens/surah_screen/surah_screen.dart';
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

  // initBox(int surahNumber) async {
  //   box = await Hive.openBox(boxName);

  //   if (box.isNotEmpty) {
  //     var prevBox = await box.get(surahNumber);

  //     if (prevBox != null) {
  //       status = prevBox['status'];
  //       currentAyah = prevBox['currentAyah'];

  //       // DateTime savedDate = prevBox['date'];
  //       // if (DateTime.now().day != savedDate.day &&
  //       //     DateTime.now().month != savedDate.month) {
  //       //   status = 'Read';
  //       //   box.put(surahNumber, {'currentAyah': 0, 'status': "Read"});
  //       // } // DateTime savedDate = prevBox['date'];
  //       // if (DateTime.now().day != savedDate.day &&
  //       //     DateTime.now().month != savedDate.month) {
  //       //   status = 'Read';
  //       //   box.put(surahNumber, {'currentAyah': 0, 'status': "Read"});
  //       // }

  //       // print(prevBox);
  //     }
  //   }

  //   notifyListeners();

  //   // setState(() {});
  // }

  // Future<void> clearProgressButtonClicked() async {
  //   Box box = await Hive.openBox(boxName);
  //   await box.clear();
  //   notifyListeners();
  // }

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

    // if (result != null) {
    //   status = result['status'];
    //   if (status != "completed") {
    //     currentAyah = result['currentAyah'];
    //     // box.put(model.surahNumber, {
    //     //   'currentAyah': currentAyah,
    //     //   'status': status,
    //     //   'date': result['date']
    //     // });
    //   } else {
    //     // box.put(model.surahNumber,
    //     //     {'currentAyah': 0, 'status': status, 'date': DateTime.now()});
    //   }
    // }

    // });
    notifyListeners();
  }

  // addFavouriteSurah() async {
  //   var box = await Hive.box('box');
  //   var List = await box.get('fav');
  //   List.add(surahNumber);
  //   box.put('fav', List);
  // }
}
