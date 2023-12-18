import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/quran.dart' as quran;
import 'package:yasin_mulk_waqiya/utils/colors.dart';

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
      Navigator.pop(context, {"status": "completed", "date": DateTime.now(),"currentAyah":0});
    }
  }

  void onBackwardButtonClicked() {
    vibrateOnButtonClick();
    controller.previousPage(
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }

    void warningMsgBeforeOnIAMDoneButtonClicked(BuildContext context, SurahScreenModel model) {
     showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: Text('Alert!!!'),),
        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0))),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Are You Sure You Want to discontinue',),
                SizedBox(height: 16,),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    model.onIamDoneButtonClicked(
                        context);
                  },
                  child: Text(
                    'EXIT',
                    style: TextStyle(
                        color: AppColors.seconderyColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor:
                        AppColors.primaryColor,
                    shape: StadiumBorder(),
                    side: BorderSide(
                      color: AppColors.seconderyColor,
                    ),
                  ),
                  onPressed: () {
                    // print(yaseenList().length);
                    // model.onIamDoneButtonClicked(context);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'CONTINUE',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              AppColors.seconderyColor),
                    ),
                  ),
                ),
                // ElevatedButton(
                //     onPressed: () {
    
                //     },
                //     child: Text('Continue'))
              ],
            )
          ],
        ),
      ),
    );
                               
  }

}
