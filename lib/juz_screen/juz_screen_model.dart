import 'package:confetti/confetti.dart';
import 'package:daily_quran/home_screen/home_screen_model.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart' as quran;

// import 'package:quran/quran.dart';

class JuzScreenModel with ChangeNotifier {
  List<Widget> finalList = [];
  Map juzMap = {};
  PageController pageController = PageController(initialPage: 0);
  var currentPageAkaCurrentAyah = 0;
  var currentPage = 0;
  late int juzNumber;
  double progressIndicator = 0.0;
  double total = 0.0;
  int remainingAyahs = 0;
  int completedPercentage = 0;
  double linearProgressTracker = 0.0;
  int currentJuzLenght = 0;

  ////////////
  String ArabicText = '';
  String englishText = '';
  String verseKey = '';
  String surahName = '';
  String surahStartingVerse = '';
  ///////////
  ConfettiController confettiController = ConfettiController(
    duration: Duration(seconds: 1),
  );

  JuzScreenModel(juzNumber, context, HomeScreenModel model) {
    this.juzNumber = juzNumber;
    this.currentJuzLenght = model.juzs[juzNumber - 1].length;
    currentPage = getCurrentPageNumber(context, juzNumber);
    updateBottomBarTrackers(model);
    pageController =
        PageController(initialPage: getCurrentPageNumber(context, juzNumber));
    pageController.addListener(() {
      currentPage = pageController.page!.round();
      updateBottomBarTrackers(model);
    });
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

  void onForwardButtonClicked(HomeScreenModel model) {
    vibrateOnButtonClick();
    currentPage = pageController.page!.round();
    updateBottomBarTrackers(model);
    pageController.nextPage(
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }

  updateBottomBarTrackers(HomeScreenModel model) {
    remainingAyahs = currentJuzLenght - 1 - currentPage;
    completedPercentage = int.parse(
        ((currentPage + 1) / currentJuzLenght * 100).toStringAsFixed(0));
    linearProgressTracker = (currentPage + 1) / currentJuzLenght;
    updateJuzTitles(model);
    if (remainingAyahs == 0) {
      celebrateCompletion();
    }
    notifyListeners();
  }

  updateJuzTitles(HomeScreenModel model) {
    var result = model.juzs[juzNumber - 1][currentPage];
    var translationResult = model.translations[juzNumber - 1][currentPage];
    ArabicText = result.text_uthmani;
    englishText = translationResult.text;
    verseKey = result.verseKey;
    surahName = quran.getSurahName(int.parse(verseKey.split(":")[0]));
    surahStartingVerse = verseKey.split(":")[1];
  }

  void onBackwardButtonClicked(HomeScreenModel model) {
    print('hi');
    vibrateOnButtonClick();
    currentPage = pageController.page!.round();
    updateBottomBarTrackers(model);

    pageController.previousPage(
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }

  void onExitButtonClicked(
    context,
    HomeScreenModel homeScreenModel,
  ) {
    var progress = pageController.page!.toDouble() / currentJuzLenght;
    homeScreenModel.updateJuzProgress(
        juzNumber, progress, pageController.page!.round());
    Navigator.pop(
      context,
    );
    print('exit');
  }

  // skip() {
  //   pageController.jumpToPage(141);
  //   notifyListeners();
  // }

  celebrateCompletion() {
    confettiController.play();
    notifyListeners();
  }
}
