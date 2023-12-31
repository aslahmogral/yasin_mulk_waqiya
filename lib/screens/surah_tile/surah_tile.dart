import 'package:daily_quran/screens/surah_tile/surah_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_quran/utils/colors.dart';
import 'package:quran/quran.dart' as quran;

class SurahTile extends StatelessWidget {
  final surahNumber;
  final String boxName;
  const SurahTile({
    super.key,
    required this.surahNumber,
    required this.boxName,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => surahTileModel(surahNumber, boxName)),
      ],
      child: Consumer<surahTileModel>(builder: (context, model, child) {
        var versesLeft = quran.getVerseCount(surahNumber) - model.currentAyah;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
              onTap: () async {
                await model.onListTileClicked(context, model);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.primaryColor
                      .withOpacity(0.7), // Optional: Set the background color
                ),
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: model.status != 'continue'
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
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                typeOfChipMethod(model.status, model),
                                moreSectionInListTile(context, model)
                              ],
                            ),
                          )
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
                            subtitle: Text(
                              "$versesLeft verses left ",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                typeOfChipMethod(model.status, model),
                                moreSectionInListTile(context, model)
                              ],
                            ))),
              )),
        );
      }),
    );
  }

  Widget typeOfChipMethod(String result, surahTileModel model) {
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

  Widget moreSectionInListTile(context, surahTileModel model) {
    return IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
                content: TextButton(
                    onPressed: () {
                      model.addFavouriteSurah();
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
