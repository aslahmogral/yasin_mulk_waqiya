import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

class SurahScreenModel with ChangeNotifier {
//  int previousVerse = 0;

  // int count = 1;
  PageController controller = PageController(initialPage: 0);
  int currentPage = 0;
  late int surahNumber;

  SurahScreenModel(int? previousVerse, int surahNumber) {
    if (previousVerse != null) {
      currentPage = previousVerse;
      this.surahNumber = surahNumber;
    }

    controller = PageController(initialPage: currentPage);

    controller.addListener(() {
      // setState(() {
      currentPage = controller.page!.toInt();
      // });
      notifyListeners();
    });
  }

  void onForwardButtonClicked() {
    print(currentPage);

    controller.nextPage(
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }

  void onIamDoneButtonClicked(BuildContext context) {
    // print(yaseenList().length);
    if (currentPage != quran.getVerseCount(surahNumber) - 1) {
      print(currentPage);
      print('continue');
      Navigator.pop(
        context,
        {"type": "continue", "verses": currentPage},
      );
      print('//////////////continue/////////////////');
      print(currentPage);
      print('////////////////continue///////////////');
    } else {
      print('exit');
      Navigator.pop(context, {
        "type": "completed",
      });
      print('//////////////com/////////////////');
      print(currentPage);
      print('////////////////continue///////////////');
    }
  }

  void onBackwardButtonClicked() {
    controller.previousPage(
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }
}
