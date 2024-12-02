import 'package:daily_quran/widgets/juz_card/juz_card_model.dart';
import 'package:daily_quran/home_screen/home_screen_model.dart.dart';
import 'package:daily_quran/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_quran/utils/colors.dart';
import 'package:badges/badges.dart' as badges;
// import 'package:quran/quran.dart' as quran;

class JuzCard extends StatelessWidget {
  final juzNumber;
  // final String boxName;
  const JuzCard({
    super.key,
    required this.juzNumber,
    // required this.boxName,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => juzCardModel(juzNumber)),
      ],
      child: Consumer<juzCardModel>(builder: (context, model, child) {
        // var versesLeft = quran.getVerseCount(surahNumber) - model.currentAyah;
        return Consumer<HomeScreenModel>(
            builder: (context, juzProgressModel, child) {
          // double progress = juzProgressModel.getJuzData(juzNumber);
          double progress = juzProgressModel.getJuzProgress(juzNumber);
          bool isJuzStarted = progress != 0.0;
          // bool isJuzFinished = progress == 100.0;
          // var percentage = progress * 100;

          //here i have added +1 because percentage shows to be 1 less eventhough it is correct inside juzSreen(quick fix)
          var percentage = Utils().calculatePercentage(progress) + 1;
          bool isJuzFinished = percentage >= 100.0;

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
                  badgeContent: !isJuzFinished && isJuzStarted
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
                      shape: isJuzFinished
                          ? badges.BadgeShape.instagram
                          : badges.BadgeShape.circle,
                      badgeColor: isJuzFinished ? Colors.green : Colors.red),
                  showBadge: isJuzStarted,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppColors.primaryColor.withOpacity(
                            0.7), // Optional: Set the background color
                      ),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8),
                          child: isJuzStarted
                              ? isJuzFinished
                                  ? completedCard()
                                  : ContinueCard(percentage)
                              : notStartedCard())),
                )),
          );
        });
      }),
    );
  }

/*************  ✨ Codeium Command ⭐  *************/
  /// Returns a [Container] widget with a [CircleAvatar] widget inside it.
  ///
  /// The [CircleAvatar] widget has the juz number as its child, and its
  /// background color is a light gray color.
  ///
  /// The [Container] widget has a padding of 8.0 on all sides.
  ///
/******  421410a8-61ad-439a-82c5-3a96d0d75870  *******/
  Container notStartedCard() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(
                child: Text(
                  '$juzNumber',
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
                                .resetSelectedJuzProgress(juzNumber);
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
                  '$juzNumber',
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
                '$juzNumber',
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

  Widget typeOfChipMethod(String result, juzCardModel model) {
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

  Widget moreSectionInListTile(context, juzCardModel model) {
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
