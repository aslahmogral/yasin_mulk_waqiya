import 'package:daily_quran/home_screen/home_screen_model.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart';

class JuzScreenModel with ChangeNotifier {
  List<Widget> finalList = [];
  Map juzMap = {};
  PageController pageController = PageController(initialPage: 0);
  var currentPageAkaCurrentAyah = 0;
  late int juzNumber;
  double progressIndicator = 0.0;
  double total = 0.0;

  JuzScreenModel(juzNumber, context) {
    juzMap = getSurahAndVersesFromJuz(juzNumber);

    this.juzNumber = juzNumber;
    pageController =
        PageController(initialPage: getCurrentPageNumber(context, juzNumber));
  
  }



  int getCurrentPageNumber(BuildContext context, int juzNumber) {
    // Get an instance of JuzProgressProvider
    final juzProvider = Provider.of<HomeScreenModel>(context, listen: false);

    // Use the getJuzCurrentPage method from JuzProgressProvider
    return juzProvider.getJuzCurrentPage(juzNumber);
  }

  vibrateOnButtonClick() {
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
        juzNumber, progress, pageController.page!.round());
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
