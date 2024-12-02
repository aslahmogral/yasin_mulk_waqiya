import 'surah_screen_model.dart';
import 'package:daily_quran/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart' as quran;
import 'package:daily_quran/utils/colors.dart';

class SurahScreen extends StatelessWidget {
  final surahNumber;
  final previousVerse;
  const SurahScreen({Key? key, required this.surahNumber, this.previousVerse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => SurahScreenModel(previousVerse, surahNumber)),
      ],
      child: Consumer<SurahScreenModel>(builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () {
            return Future(() => false);
          },
          child: Scaffold(
            body: PageView(
              controller: model.controller,
              children: [...AyahList(context, model)],
              physics: NeverScrollableScrollPhysics(),
            ),
            floatingActionButton: bottomButtons(model, context),
            // bottomNavigationBar: Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Container(
            //     color: Colors.transparent,

            //     height: 180,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         //left button ------------------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

            //         //right button ------------------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            //       ],
            //     ),
            //   ),
            // ),
          ),
        );
      }),
    );
  }

  Padding bottomButtons(SurahScreenModel model, BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 32,
                ),
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
                Spacer(), //middle iam done button ------------------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

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
                          model.onExitButtonClicked(context);
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
                          model.warningMsgBeforeOnIAMDoneButtonClicked(
                            context,
                          );
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
                Spacer(),
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
              ],
            ),
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
    model.isSajdahCheck(model.currentPageAkaCurrentAyah + 1);
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
                                              height: 2,
                                              fontFamily: 'AmiriQuran',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 28,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          model.isSajdah
                                              ? Text(
                                                  '۩ SAJDAH ۩',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 16,),
                                    Text(quran.getVerseTranslation(
                                        surahNumber, i)),
                                    SizedBox(
                                      height: 150,
                                    )
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
