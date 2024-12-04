import 'package:confetti/confetti.dart';
import 'package:daily_quran/home_screen/home_screen_model.dart.dart';
import 'package:daily_quran/juz_screen/juz_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_quran/utils/colors.dart';

class JuzScreen extends StatelessWidget {
  final juzNumber;
  final previousVerse;
  const JuzScreen({Key? key, required this.juzNumber, this.previousVerse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenModel>(
      builder: (context, HomeScreenModel, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) =>
                    JuzScreenModel(juzNumber, context, HomeScreenModel)),
          ],
          child: Consumer<JuzScreenModel>(
            builder: (context, model, child) {
              return PopScope(
                canPop: false,
                onPopInvokedWithResult: (didPop, result) {
                  if (didPop) {
                    return;
                  } else {
                    // model.showWarning(HomeScreenModel, context);
                    model.onExitButtonClicked(context, HomeScreenModel);
                  }
                },
                child: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        model.onExitButtonClicked(context, HomeScreenModel);
                      },
                    ),
                    centerTitle: true,
                    title: Text(
                      'JUZ ${juzNumber} , ${model.surahName} ${model.verseKey}',
                    ),
                  ),
                  body: Stack(
                    children: [
                      PageView.builder(
                          itemCount: HomeScreenModel.juzs[juzNumber - 1].length,
                          controller: model.pageController,
                          itemBuilder: (context, index) {
                           
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Stack(
                                children: [
                                  SingleChildScrollView(
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              gradient: WirdGradients
                                                  .listTileShadeGradient,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: WirdColors.primaryDaycolor,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Visibility(
                                                  visible:
                                                      model.surahStartingVerse == '1',
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: Text(
                                                      '﷽',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  model.ArabicText,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 24,
                                                    fontFamily: 'Kfgqpc',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Visibility(
                                            visible:
                                                // ThemeProvider.isTransliteration,
                                                true,
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: WirdGradients
                                                        .listTileShadeGradient
                                                        .colors
                                                        .last
                                                        .withOpacity(0.5),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(16.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                          model.englishText,
                                                          // textAlign: TextAlign.left,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                                fontSize: 16,
                                                              )),
                                                    ],
                                                  ),
                                                )),
                                          ),
                                          // SizedBox(
                                          //   height: 16,
                                          // ),
                                          // Visibility(
                                          //   visible:
                                          //       ThemeProvider.isEnglishTranslation,
                                          //   child: Container(
                                          //       decoration: BoxDecoration(
                                          //         border: Border.all(
                                          //           color: WirdGradients
                                          //               .listTileShadeGradient
                                          //               .colors
                                          //               .last
                                          //               .withOpacity(0.5),
                                          //           width: 2,
                                          //         ),
                                          //         borderRadius:
                                          //             BorderRadius.circular(15),
                                          //       ),
                                          //       child: Padding(
                                          //         padding:
                                          //             const EdgeInsets.all(20.0),
                                          //         child: Column(
                                          //           children: [
                                          //             // Text('TRANSLATION',
                                          //             //     textAlign: TextAlign.center,
                                          //             //     style: Theme.of(context)
                                          //             //         .textTheme
                                          //             //         .headlineSmall
                                          //             //         ?.copyWith(
                                          //             //             fontSize: 14,
                                          //             //             )),
                                          //             // SizedBox(
                                          //             //   height: 16,
                                          //             // ),
                                          //             Text(
                                          //                 model.wirdList[index]
                                          //                     .english
                                          //                     .replaceAll(
                                          //                         RegExp(r'[˹˺]'),
                                          //                         ''),
                                          //                 textAlign: TextAlign.left,
                                          //                 style: Theme.of(context)
                                          //                     .textTheme
                                          //                     .headlineSmall
                                          //                     ?.copyWith(
                                          //                       fontSize: 16,
                                          //                     )),
                                          //           ],
                                          //         ),
                                          //       )),
                                          // ),
                                          SizedBox(
                                            height: 100,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: bottomBar(
                          model: model,
                          homeScreenModel: HomeScreenModel,
                        ),
                      ),
                    ],
                  ),

                  // PageView(
                  //   controller: model.pageController,
                  //   children: [...AyahList(context, model)],
                  //   physics: NeverScrollableScrollPhysics(),
                  // ),
                  // floatingActionButton:
                  //     bottomButtons(model, context, HomeScreenModel),
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
            },
          ),
        );
      },
    );
  }
}

class ThemeProvider {
}

class bottomBar extends StatelessWidget {
  final JuzScreenModel model;
  final HomeScreenModel homeScreenModel;
  const bottomBar({
    super.key,
    required this.model,
    required this.homeScreenModel,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          model.onBackwardButtonClicked(homeScreenModel);
                        },
                        icon: Icon(Icons.skip_previous),
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      // if (model.pageController.page == 0)
                      //   InkWell(
                      //     onTap: () {

                      //     },
                      //     child: Column(
                      //       mainAxisSize: MainAxisSize.min,
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Text(
                      //           '0%',
                      //           style: TextStyle(color: Colors.white),
                      //         ),
                      //         Text(
                      //           'Completed',
                      //           style: TextStyle(
                      //               fontSize: 10, color: Colors.white),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      Visibility(
                        // visible: model.currentPage != 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              // '${((model.currentPage + 1) / homeScreenModel.juzs[model.juzNumber - 1].length * 100).toStringAsFixed(0)} % ',
                              "${model.completedPercentage.toString()} %",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Completed',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              model.remainingAyahs.toString(),
                              // '',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Remaining',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      IconButton(
                        onPressed: () {
                          model.onForwardButtonClicked(homeScreenModel);
                        },
                        icon: Icon(Icons.skip_next),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).primaryColor,
                ),
                height: 60,
                width: MediaQuery.of(context).size.width,
              ),

              //linear progress indicator
              // Container(
              //   height: 60,
              //   child: Column(
              //     children: [
              //       Spacer(),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //         child: TweenAnimationBuilder<double>(
              //             tween: Tween<double>(
              //                 begin: 0.0, end: model.linearProgressTracker),
              //             duration: const Duration(milliseconds: 300),
              //             builder: (context, value, _) {
              //               return LinearProgressIndicator(
              //                   borderRadius:
              //                       BorderRadius.all(Radius.circular(20)),
              //                   // color: Colors.teal,

              //                   // color: Theme.of(context)
              //                   //     .textTheme
              //                   //     .bodyMedium
              //                   //     ?.color,

              //                   minHeight: 6,
              //                   value: value);
              //             }),
              //       ),
              //     ],
              //   ),
              // ),

              //circular progress indicator
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ConfettiWidget(
                colors: [Colors.teal, Colors.white, Colors.black],
                blastDirection: 270,
                numberOfParticles: 20,
                gravity: 0.1,
                blastDirectionality:
                    BlastDirectionality.directional, // up direction
                confettiController: model.confettiController),
          ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
                colors: [Colors.teal, Colors.white, Colors.black],
                // blastDirection: 180,
                numberOfParticles: 10,
                gravity: 0.0,
                blastDirectionality:
                    BlastDirectionality.explosive, // up direction
                confettiController: model.confettiController),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ConfettiWidget(
                colors: [Colors.teal, Colors.white, Colors.black],
                blastDirection: 180,
                numberOfParticles: 20,
                gravity: 0.1,
                blastDirectionality:
                    BlastDirectionality.directional, // up direction
                confettiController: model.confettiController),
          ),
          counter(context, homeScreenModel)
        ],
      ),
    );
  }

  InkWell counter(BuildContext context, HomeScreenModel homeScreenModel) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        model.onForwardButtonClicked(homeScreenModel);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).scaffoldBackgroundColor),
                  height: 100,
                  width: 100),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: TweenAnimationBuilder<double>(
                            tween: Tween<double>(
                                begin: 0.0, end: model.linearProgressTracker),
                            duration: Duration(
                              milliseconds: 300,
                            ),
                            builder: (context, value, _) {
                              return CircularProgressIndicator(
                                // value: value,
                                value: value,

                                valueColor: AlwaysStoppedAnimation<Color>(
                                  WirdColors.primaryDaycolor,
                                ),
                              );
                            }),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        child: Center(
                          child: Text(
                            '${model.currentPage + 1} / ${model.currentJuzLenght}',
                            // "${model.wirdList[model.currentPage].counted != null ? model.currentPageWirdCounted : 0}/${model.wirdList[model.currentPage].count.toString()}",
                          ),
                        ),
                      ),
                      Visibility(

                        // visible: model.wirdList[model.currentPage ].completed ??
                        //     false,
                        // visible: model.checkIfCurrentWirdCompleted(),
                        visible: model.currentPage == model.currentJuzLenght - 1,
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: WirdColors.primaryDaycolor,
                              gradient: WirdGradients.listTileShadeGradient),
                          child: Center(
                            child:  Center(
                            child: Icon(
                              size: 35,
                              Icons.done_all,
                              color: Colors.white,
                            ),
                          ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: WirdColors.primaryDaycolor,
                                gradient: WirdGradients.listTileShadeGradient),
                            child: Center(
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'TAPP ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                Icon(Icons.touch_app, color: Colors.white)
                              ],
                            ))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }
}
