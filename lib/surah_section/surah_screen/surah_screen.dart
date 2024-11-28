import 'package:daily_quran/juz_section/juz_provider.dart';
import 'package:daily_quran/juz_section/juz_screen/juz_screen_mode.dart';
import 'package:daily_quran/references/screens/surah_screen/surah_screen_model.dart';
import 'package:daily_quran/utils/utils.dart';
import 'package:daily_quran/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart' as quran;
import 'package:daily_quran/utils/colors.dart';
import 'package:badges/badges.dart' as badges;

class JuzScreen extends StatelessWidget {
  final juzNumber;
  final previousVerse;
  const JuzScreen({Key? key, required this.juzNumber, this.previousVerse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => JuzScreenModel(juzNumber, context)),
      ],
      child: Consumer<JuzScreenModel>(builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () {
            return Future(() => false);
          },
          child: Scaffold(
            body: PageView(
              controller: model.pageController,
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

  Padding bottomButtons(JuzScreenModel model, BuildContext context) {
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
                  onPressed: () {
                    print('null');
                    model.onBackwardButtonClicked();
                  },
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

          model.currentPageAkaCurrentAyah == quran.getVerseCount(juzNumber) - 1
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
                    // model.onExitButtonClicked(context);
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
              : Consumer<JuzProgressProvider>(
                  builder: (context, juzProgressModel, child) {
                  return TextButton(
                    // style: OutlinedButton.styleFrom(
                    //   shape: StadiumBorder(),
                    //   side: BorderSide(color: AppColors.seconderyColor),
                    // ),
                    onPressed: () {
                      // print(yaseenList().length);
                      // model.warningMsgBeforeOnIAMDoneButtonClicked(
                      //   context,
                      // );
                      model.onExitButtonClicked(context, juzProgressModel);
                    },
                    child: Text(
                      'I AM DONE',
                      style: TextStyle(
                          color: AppColors.seconderyColor,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }),

          // middle iam  button ------------------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
          Spacer(),
          //right button ------------------------>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
          model.currentPageAkaCurrentAyah == quran.getVerseCount(juzNumber) - 1
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

  Column appBarArea(BuildContext context, JuzScreenModel model,
      {required int surahkey,
      required int ayahNumber,
      required int surahLastAyahNumber,
      required double progressIndicator,
      required List surahsInJuz}) {
    var percentage = Utils().calculatePercentage(progressIndicator);
    // var percentage = progressIndicator * 100;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              child: Image.asset('assets/masjid_arc.png'),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      quran.getVerseEndSymbol(juzNumber),
                      style: TextStyle(fontSize: 22),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  model.skip();
                                },
                                child: Text(
                                  '$surahkey. ${quran.getSurahName(surahkey)}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              // Text('$ayahNumber'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: badges.Badge(
                        badgeContent: Text(
                          '$percentage %',
                          style: TextStyle(
                              fontSize: 6, fontWeight: FontWeight.bold),
                        ),
                        badgeStyle: badges.BadgeStyle(
                            badgeColor: AppColors.seconderyColor),
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.primaryColor,
                          backgroundColor:
                              AppColors.seconderyColor.withOpacity(0.5),
                          // minHeight: 20,
                          value: model.progressIndicator,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Stack(
        //   children: [
        //     // LinearProgressIndicator(
        //     //   color: AppColors.primaryColor,
        //     //   backgroundColor: AppColors.seconderyColor.withOpacity(0.5),
        //     //   // minHeight: 20,
        //     //   value: model.progressIndicator,
        //     // ),
        //     Row(
        //       children: [
        //         // Expanded(
        //         //   child: SizedBox(
        //         //     width: 10,
        //         //   ),
        //         // ),
        //         // Padding(
        //         //   padding: const EdgeInsets.all(8.0),
        //         //   child: Column(
        //         //     crossAxisAlignment: CrossAxisAlignment.start,
        //         //     children: [
        //         //       Container(
        //         //         height: 50,
        //         //         child: SingleChildScrollView(
        //         //           child: Column(
        //         //             mainAxisSize: MainAxisSize.min,
        //         //             children: [
        //         //               ...surahsInJuz,
        //         //             ],
        //         //           ),
        //         //         ),
        //         //       ),
        //         //       SizedBox(
        //         //         width: 10,
        //         //       ),
        //         //     ],
        //         //   ),
        //         // ),
        //       ],
        //     )
        //   ],
        // )
      ],
    );
  }

  List<Widget> AyahList(BuildContext context, JuzScreenModel model) {
    // model.isSajdahCheck(model.currentPageAkaCurrentAyah + 1);
    // int verseCount = quran.getVerseCount(juzNumber);
    // int verseLeft = verseCount - model.currentPageAkaCurrentAyah - 1;

    // juzMap.forEach((key, value) {
    //   // finalList.add(Text(basmala));
    //   for (int i = value[0]; i <= value[1]; i++) {
    //     finalList.add(Text(getVerse(key, i)));
    //   }
    // });
    int currentCountInJuz = 0;

    // int totalAyahsInJuz = 155;

    model.juzMap.values.forEach((value) {
      var subTotal = 0;
      if (value[0] != 1) {
        subTotal = value[1] - value[0];
        model.total += subTotal;
      } else {
        model.total += value[1];
      }
      // Summing up the values
    });
    List<Widget> surahsInJuz = [];
    int juzMapLength = model.juzMap.keys.toList().length;

    print('=====================$juzMapLength');
    int keyCount = 0;
    model.juzMap.forEach((key, value) {
      keyCount++;
      String surahInfo = '${value[0]} to ${value[1]}';
      // Chip(label: )
      surahsInJuz.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                '$key - ${quran.getSurahName(key)} ${juzMapLength == keyCount ? surahInfo : ''}',
                style: TextStyle(fontSize: 8),
              ),
            ),
            decoration: BoxDecoration(
              // color: Colors.blue,
              borderRadius:
                  BorderRadius.circular(10), // Adjust the corner radius
              border: Border.all(
                color: Colors.black45, // Change this color
                width: 0.5, // Adjust the border thickness
              ),
            ),
          )

          // Chip(
          //   padding: EdgeInsets.zero,
          //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //   label: Text(
          //     '$key - ${quran.getSurahName(key)} ${juzMapLength == keyCount ? surahInfo  : ''}',
          //     style: TextStyle(fontSize: 8),
          //   ),
          // ),
          ));
    });

    List<Widget> finalList = [];
    bool isSurahFirstAyah = false;
    model.juzMap.forEach((surahKey, ayahList) {
      isSurahFirstAyah = true;
      //here i = ayahNumber
      //surah fathiha {1 : [value[0] = 1,value[1] = 7] }
      for (int i = ayahList[0]; i <= ayahList[1]; i++) {
        currentCountInJuz++;
        var trackProgress = currentCountInJuz / model.total;
        model.progressIndicator = trackProgress;

        finalList.add(
          Column(
            children: [
              appBarArea(context, model,
                  surahkey: surahKey,
                  ayahNumber: i,
                  surahLastAyahNumber: ayahList[1],
                  progressIndicator: trackProgress,
                  surahsInJuz: surahsInJuz),
              SizedBox(
                height: 6,
              ),
              Container(
                height: 30,
                child: Scrollbar(
                  thickness: 1,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        ...surahsInJuz,
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Text('$verseLeft Verses Left'),
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
                                // width: MediaQuery.of(context).size.width * 0.8,
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            //key != 0 for checking if it is not fathiha
                                            if (isSurahFirstAyah &&
                                                surahKey != 1)
                                              Image.asset(
                                                  'assets/bismillah.png'),
                                            Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Text(
                                                  '${quran.getVerse(surahKey, i)} ${quran.getVerseEndSymbol(i)}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    height: 2,
                                                    fontFamily: 'AmiriQuran',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 28,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            // model.isSajdah
                                            //     ? Text(
                                            //         '۩ SAJDAH ۩',
                                            //         style: TextStyle(
                                            //             fontWeight:
                                            //                 FontWeight.bold,
                                            //             color: Colors.red),
                                            //       )
                                            //     : SizedBox()
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(quran.getVerseTranslation(
                                          surahKey, i)),
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
        isSurahFirstAyah = false;
      }
    });

    return finalList;
  }
}
