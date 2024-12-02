// import 'package:daily_quran/juz_section/juz_card/juz_card.dart';
// import 'package:daily_quran/juz_section/juz_provider.dart';
import 'surah_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../references/screens/surah_index_screen/surah_index_model.dart';
import 'package:daily_quran/utils/colors.dart';

class SurahIndexScreen extends StatefulWidget {
  const SurahIndexScreen({
    super.key,
  });

  @override
  State<SurahIndexScreen> createState() => _SurahIndexScreenState();
}

class _SurahIndexScreenState extends State<SurahIndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 243, 220),
      appBar: AppBar(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.account_circle),
          ],
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Daily Quran',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.seconderyColor),
        ),
        actions: [
       
        ],
      ),
      body: Consumer<SurahProgressProvider>(
        builder: (context,model,child) {
          return SingleChildScrollView(
            child:Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      children: [
                        GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                4, // You can adjust the number of columns as needed
                            crossAxisSpacing: 1.0,
                            mainAxisSpacing: 1.0,
                          ),
                          itemCount: model.surahList.length,
                          shrinkWrap: true,
                          physics:
                              NeverScrollableScrollPhysics(), // to prevent scrolling of GridView within SingleChildScrollView
                          itemBuilder: (context, index) {
                            return GridTile(
                              child: Container(
                                // Your content for each grid item here
                                child: model.surahList[
                                    index], // Replace YourWidget with your actual widget
                              ),
                            );
                          },
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.primaryColor),
                            ),
                            onPressed: () {
                              // resetButtonClicked(context, model);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'RESET',
                                  style: TextStyle(
                                      color: AppColors.seconderyColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
          );
        }
      ),
    );
  }

  Future<dynamic> resetButtonClicked(
      BuildContext context, SurahProgressProvider model) {
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
                Consumer<SurahProgressProvider>(
                    builder: (context, model, child) {
                  return Column(
                    children: [
                      Visibility(
                        visible: !model.shouldReset,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.seconderyColor),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Close',
                            style: TextStyle(
                                color: AppColors.primaryColor,
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
                            model.resetAllSurahProgress();
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
}
