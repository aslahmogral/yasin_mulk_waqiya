import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yasin_mulk_waqiya/utils/colors.dart';
import 'package:quran/quran.dart' as quran;
import 'package:yasin_mulk_waqiya/screens/surah_list_tile/surah_list_tile_model.dart';

class SurahListTile extends StatelessWidget {
  final surahNumber;
  // final previousVerse;
  const SurahListTile({
    super.key,
    required this.surahNumber,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => surahListTieModel(surahNumber)),
      ],
      child: Consumer<surahListTieModel>(builder: (context, model, child) {
        var versesLeft = quran.getVerseCount(surahNumber) - model.currentAyah;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
              onTap: () async {
                await model.onListTileClicked(context, model);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors
                      .primaryColor, // Optional: Set the background color
                ),
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: model.status != 'completed'
                        ? ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                '$surahNumber',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: AppColors.seconderyColor,
                            ),
                            title: Text(
                              quran.getSurahName(surahNumber),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "$versesLeft verses left ",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: typeOfChipMethod(model.status, model))
                        : ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                '$surahNumber',
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: AppColors.seconderyColor,
                            ),
                            title: Text(
                              quran.getSurahName(surahNumber),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: typeOfChipMethod(model.status, model))),
              )),
        );
      }),
    );
  }

  Widget typeOfChipMethod(String result, surahListTieModel model) {
    if (result == 'continue') {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Chip(
            label: Text(
              'continue',
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
        label: Text(
          'Read',
        ),
        backgroundColor: Colors.red,
      );
    }
    // return finalString;
  }
}
