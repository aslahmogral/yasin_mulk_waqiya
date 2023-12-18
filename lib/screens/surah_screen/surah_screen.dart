import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart' as quran;
import 'package:yasin_mulk_waqiya/screens/surah_screen/surah_screen_model.dart';
import 'package:yasin_mulk_waqiya/utils/colors.dart';
import 'package:yasin_mulk_waqiya/widgets/button.dart';

class SurahWidget extends StatelessWidget {
  final surahNumber;
  final previousVerse;
  const SurahWidget({Key? key, required this.surahNumber, this.previousVerse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => SurahScreenModel(previousVerse, surahNumber)),
      ],
      child: Consumer<SurahScreenModel>(builder: (context, model, child) {
        return Scaffold(
          body: PageView(
            controller: model.controller,
            children: [...AyahList(context, model)],
            physics: NeverScrollableScrollPhysics(),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //left button ------------------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                  model.currentPageAkaCurrentAyah == 0
                      ? QButton(
                          buttonColor: Colors.transparent,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black45,
                          ),
                          onPressed: () {},
                        )
                      : QButton(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.seconderyColor,
                          ),
                          onPressed: () {
                            model.onBackwardButtonClicked();
                          },
                        ),
                  //left button ------------------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

                  //middle iam done button ------------------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

                  model.currentPageAkaCurrentAyah ==
                          quran.getVerseCount(surahNumber) - 1
                      ? OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: StadiumBorder(),
                            side: BorderSide(
                              color: AppColors.seconderyColor,
                            ),
                          ),
                          onPressed: () {
                            // print(yaseenList().length);
                            model.onIamDoneButtonClicked(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'I AM DONE',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.seconderyColor),
                            ),
                          ),
                        )
                      : TextButton(
                          // style: OutlinedButton.styleFrom(
                          //   shape: StadiumBorder(),
                          //   side: BorderSide(color: AppColors.seconderyColor),
                          // ),
                          onPressed: () {
                            // print(yaseenList().length);
                            model.warningMsgBeforeOnIAMDoneButtonClicked(context, model);
                            // model.onIamDoneButtonClicked(context);
                          },
                          child: Text(
                            'I AM DONE',
                            style: TextStyle(
                                color: AppColors.seconderyColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                  //middle iam  button ------------------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

                  //right button ------------------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                  model.currentPageAkaCurrentAyah ==
                          quran.getVerseCount(surahNumber) - 1
                      ? QButton(
                          buttonColor: Colors.transparent,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black45,
                          ),
                          onPressed: () {},
                        )
                      : QButton(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.seconderyColor,
                          ),
                          onPressed: () {
                            model.onForwardButtonClicked();
                          },
                        ),

                  //right button ------------------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                ],
              ),
            ),
          ),
        );
      }),
    );
  }


  Stack appBarArea(BuildContext context, SurahScreenModel model) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          child: Image.asset('assets/masjid_arc.png'),
        ),
        Positioned(
          bottom: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$surahNumber. ${quran.getSurahName(surahNumber)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                          ' (${model.currentPageAkaCurrentAyah + 1}/${quran.getVerseCount(surahNumber).toString()})'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> AyahList(BuildContext context, SurahScreenModel model) {
    int verseCount = quran.getVerseCount(surahNumber);
    int verseLeft = verseCount - model.currentPageAkaCurrentAyah - 1;
    List<Widget> finalList = [];
    for (int i = 1; i <= verseCount; i++) {
      finalList.add(
        Column(
          children: [
            appBarArea(context, model),
            SizedBox(height: 16),
            Text('$verseLeft Verses Left'),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 40),
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (model.currentPageAkaCurrentAyah ==
                                              0)
                                            Image.asset('assets/bismillah.png'),
                                          Text(
                                            quran.getVerse(surahNumber, i),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'AmiriQuran',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 28,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 40),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return finalList;
  }
}
