import 'package:daily_quran/widgets/juz_card/juz_card_model.dart';
import 'package:daily_quran/home_screen/home_screen_model.dart.dart';
import '../../references/screens/surah_card/surah_card_model.dart';
import 'package:daily_quran/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_quran/utils/colors.dart';
import 'package:badges/badges.dart' as badges;
// import 'package:quran/quran.dart' as quran;

class surahCard extends StatelessWidget {
  final surahNumber;
  const surahCard({
    super.key,
    required this.surahNumber,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => juzCardModel(surahNumber)),
      ],
      child: Consumer<juzCardModel>(builder: (context, model, child) {
        // var versesLeft = quran.getVerseCount(surahNumber) - model.currentAyah;
        return Consumer<HomeScreenModel>(
            builder: (context, juzProgressModel, child) {
          // double progress = juzProgressModel.getJuzData(juzNumber);
          double progress = juzProgressModel.getJuzProgress(surahNumber);
          bool isSurahStarted = progress != 0.0;
          // bool isJuzFinished = progress == 100.0;
          // var percentage = progress * 100;

          //here i have added +1 because percentage shows to be 1 less eventhough it is correct inside juzSreen(quick fix)
          var percentage = Utils().calculatePercentage(progress) + 1;
          bool isSurahFinished = percentage >= 100.0;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () async {
                  await model.onListTileClicked(context, model);
                },
                onLongPress: () {
                  // juzProgressModel.resetSelectedJuzProgress(juzNumber);
                  resetButtonClicked(context, model);
                },
                child: badges.Badge(
                  // badgeAnimation: !isJuzFinished
                  //     ? badges.BadgeAnimation.scale(loopAnimation: true)
                  //     : badges.BadgeAnimation.scale(),
                  badgeContent: !isSurahFinished && isSurahStarted
                      ? Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            '${percentage.toInt()} %',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )
                      : Icon(Icons.check),
                  badgeStyle: badges.BadgeStyle(
                      shape: isSurahFinished
                          ? badges.BadgeShape.instagram
                          : badges.BadgeShape.circle,
                      badgeColor: isSurahFinished ? Colors.green : Colors.red),
                  showBadge: isSurahStarted,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppColors.primaryColor.withOpacity(
                            0.7), // Optional: Set the background color
                      ),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8),
                          child: isSurahStarted
                              ? isSurahFinished
                                  ? completedCard()
                                  : ContinueCard(percentage)
                              : notStartedCard())),
                )),
          );
        });
      }),
    );
  }

  Container notStartedCard() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(
                child: Text(
                  '$surahNumber',
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.black26),
          ],
        ),
      ),
    );
  }

  Future<dynamic> resetButtonClicked(BuildContext context, juzCardModel model) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(builder: (thisLowerContext, innerSetState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                        value: model.shouldReset,
                        onChanged: (val) {
                          innerSetState(() {
                            model.updateShouldReset(val!);
                          });
                        }),
                    Column(
                      children: [
                        Text('Are you Sure '),
                        Text('You Want to Reset ???')
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Consumer<HomeScreenModel>(
                    builder: (context, juzProgressModel, child) {
                  return Column(
                    children: [
                      Visibility(
                        visible: !model.shouldReset,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.primaryColor),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Close',
                            style: TextStyle(
                                color: AppColors.seconderyColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: model.shouldReset,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.primaryColor),
                          ),
                          onPressed: () {
                            if (model.shouldReset) {}
                            // juzProgressModel.resetAllJuzProgress();
                            juzProgressModel
                                .resetSelectedJuzProgress(surahNumber);
                            innerSetState(() {
                              model.updateShouldReset(false);
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            'RESET',
                            style: TextStyle(
                                color: AppColors.seconderyColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  );
                })
              ],
            );
          }),
        );
      },
    );
  }

  Badge ContinueCard(int percentage) {
    return Badge(
      label: Text('${percentage.toInt()} %'),
      isLabelVisible: false,
      // !isJuzFinished && isJuzStarted,
      textColor: Colors.white,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                child: Text(
                  '$surahNumber',
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: AppColors.seconderyColor,
              ),
            ],
          ),
        ),

        // title: Text(
        //   // quran.getSurahName(juzNumber),
        //   juzNumber.toString(),
        //   style: TextStyle(
        //       color: Colors.white,
        //       fontWeight: FontWeight.bold),
        // ),
        // trailing: Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     typeOfChipMethod(model.status, model),
        //     moreSectionInListTile(context, model)
        //   ],
        // ),
      ),
    );
  }

  Container completedCard() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(
              child: Text(
                '$surahNumber',
                style: TextStyle(
                    color: AppColors.primaryColor, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Color.fromARGB(255, 9, 176, 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget typeOfChipMethod(String result, surahCardModel model) {
    if (result == 'continue') {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Chip(
            label: Text(
              'continue',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            backgroundColor: Colors.yellow,
          ),
        ],
      );
    } else if (result == 'completed') {
      return Chip(
        label: Text(
          'completed',
        ),
        backgroundColor: Colors.green,
      );
    } else {
      return Chip(
        label: Text('Read',
            style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
      );
    }
    // return finalString;
  }

  Widget moreSectionInListTile(context, surahCardModel model) {
    return IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
                content: TextButton(
                    onPressed: () {
                      // model.addFavouriteSurah();
                    },
                    child: Text('Add to favorite'))),
          );
        },
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ));
  }
}
