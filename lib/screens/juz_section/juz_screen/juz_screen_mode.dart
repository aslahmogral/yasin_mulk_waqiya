import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/quran.dart';

class JuzScreenModel with ChangeNotifier {
  List<Widget> finalList = [];
  Map juzMap = {};
  PageController controller = PageController(initialPage: 0);
  int currentPageAkaCurrentAyah = 0;
  late int juzNumber;

  JuzScreenModel(juzNumber) {
    juzMap = getSurahAndVersesFromJuz(juzNumber);
    // juzMap.forEach((key, value) {
    //   // finalList.add(Text(basmala));
    //   for (int i = value[0]; i <= value[1]; i++) {
    //     finalList.add(Text(getVerse(key, i)));
    //   }
    // });
  }

  void initMethod(int? previousVerse, int juzNumber) {
    if (previousVerse != null) {
      // currentPageAkaCurrentAyah = previousVerse;
      this.juzNumber = juzNumber;
    }
    controller = PageController(initialPage: currentPageAkaCurrentAyah);
    controller.addListener(() {
      currentPageAkaCurrentAyah = controller.page!.toInt();
      notifyListeners();
    });
  }

  vibrateOnButtonClick() {
    // Clipboard.setData(ClipboardData(text: ''));
    HapticFeedback.lightImpact();
  }

  void onForwardButtonClicked() {
    vibrateOnButtonClick();
    print(currentPageAkaCurrentAyah);

    controller.nextPage(
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }

  void onBackwardButtonClicked() {
    print('hi');
    vibrateOnButtonClick();
    controller.previousPage(
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }
}
