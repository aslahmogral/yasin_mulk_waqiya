import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/quran.dart' as quran;

class SurahScreenModel with ChangeNotifier {
  PageController controller = PageController(initialPage: 0);
  int currentPageAkaCurrentAyah = 0;
  late int surahNumber;

  SurahScreenModel(int? previousVerse, int surahNumber) {
    initMethod(previousVerse, surahNumber);
  }

  vibrateOnButtonClick() {
    Clipboard.setData(ClipboardData());
    HapticFeedback.lightImpact();
  }

  void initMethod(int? previousVerse, int surahNumber) {
    if (previousVerse != null) {
      currentPageAkaCurrentAyah = previousVerse;
      this.surahNumber = surahNumber;
    }
    controller = PageController(initialPage: currentPageAkaCurrentAyah);
    controller.addListener(() {
      currentPageAkaCurrentAyah = controller.page!.toInt();
      notifyListeners();
    });
  }

  void onForwardButtonClicked() {
    vibrateOnButtonClick();
    print(currentPageAkaCurrentAyah);

    controller.nextPage(
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }

  void onIamDoneButtonClicked(BuildContext context) {
    vibrateOnButtonClick();
    if (currentPageAkaCurrentAyah != quran.getVerseCount(surahNumber) - 1) {
      print(currentPageAkaCurrentAyah);
      Navigator.pop(
        context,
        {
          "status": "continue",
          "currentAyah": currentPageAkaCurrentAyah,
          "date": DateTime.now()
        },
      );
    } else {
      Navigator.pop(context, {"status": "completed", "date": DateTime.now()});
    }
  }

  void onBackwardButtonClicked() {
    vibrateOnButtonClick();
    controller.previousPage(
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }
}
