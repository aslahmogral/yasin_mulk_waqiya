import 'package:daily_quran/home_screen/home_screen_model.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart';

class SurahScreenModel with ChangeNotifier {
  List<Widget> finalList = [];
  Map surahMap = {};
  PageController pageController = PageController(initialPage: 0);
  var currentPageAkaCurrentAyah = 0;
  late int surahNumber;
  double progressIndicator = 0.0;
  double total = 0.0;

  SurahScreenModel(surahNumber, context) {
    surahMap = getSurahAndVersesFromJuz(surahNumber);

    this.surahNumber = surahNumber;
    pageController =
        PageController(initialPage: getCurrentPageNumber(context, surahNumber));
    // juzMap.forEach((key, value) {
    //   // finalList.add(Text(basmala));
    //   for (int i = value[0]; i <= value[1]; i++) {
    //     finalList.add(Text(getVerse(key, i)));
    //   }
    // });
  }

  // void initMethod(int? previousVerse, int juzNumber) {
  //   if (previousVerse != null) {
  //     // currentPageAkaCurrentAyah = previousVerse;
  //     this.juzNumber = juzNumber;
  //   }
  //   pageController = PageController(initialPage: currentPageAkaCurrentAyah);
  //   pageController.addListener(() {
  //     currentPageAkaCurrentAyah = pageController.page!.toInt();
  //     notifyListeners();
  //   });
  // }

  int getCurrentPageNumber(BuildContext context, int juzNumber) {
    // Get an instance of JuzProgressProvider
    final juzProvider = Provider.of<HomeScreenModel>(context, listen: false);

    // Use the getJuzCurrentPage method from JuzProgressProvider
    return juzProvider.getJuzCurrentPage(juzNumber);
  }

  vibrateOnButtonClick() {
    // Clipboard.setData(ClipboardData(text: ''));
    HapticFeedback.lightImpact();
  }

  void onForwardButtonClicked() {
    vibrateOnButtonClick();
    print(currentPageAkaCurrentAyah);

    pageController.nextPage(
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }

  void onBackwardButtonClicked() {
    print('hi');
    vibrateOnButtonClick();
    pageController.previousPage(
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }

  void onExitButtonClicked(context, HomeScreenModel juzProgressModel) {
    var progress = pageController.page!.toDouble() / total;
    juzProgressModel.updateJuzProgress(
        surahNumber, progress, pageController.page!.round());
    Navigator.pop(
      context,
    );
    print('exit');
  }

  skip() {
    pageController.jumpToPage(141);
    notifyListeners();
  }
}
