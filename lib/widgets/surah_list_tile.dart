import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:yasin_mulk_waqiya/screens/surah_widget.dart';
import 'package:yasin_mulk_waqiya/utils/colors.dart';
import 'package:quran/quran.dart' as quran;

class SurahListTile extends StatefulWidget {
  final surahNumber;
  // final previousVerse;
  const SurahListTile({
    super.key,
    required this.surahNumber,
  });

  @override
  State<SurahListTile> createState() => _SurahListTileState();
}

class _SurahListTileState extends State<SurahListTile> {
  String progressOfSurah = '';
  var previousVerse = 0;
  late Box box;

  Widget typeOfChipMethod(String result) {
    if (result == 'continue') {
      var rverses = quran.getVerseCount(widget.surahNumber) - previousVerse;
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$rverses verses left ",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 8,
          ),
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

  @override
  void initState() {
    initBox();
    super.initState();
  }

  initBox() async {
    box = await Hive.openBox('box');
    if (box.isNotEmpty) {
      var prev = await box.get(widget.surahNumber);
      progressOfSurah = prev['progress'];
      previousVerse = prev['previousVerse'];
      print(prev);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
          onTap: () async {
            var result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SurahWidget(
                    surahNumber: widget.surahNumber,
                    previousVerse: previousVerse,
                  ),
                ));

            setState(() {
              progressOfSurah = result['type'];
              if (progressOfSurah != "completed") {
                previousVerse = result['verses'];
                box.put(widget.surahNumber, {
                  'previousVerse': previousVerse,
                  'progress': progressOfSurah
                });
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color:
                  AppColors.primaryColor, // Optional: Set the background color
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      '${widget.surahNumber}',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: AppColors.seconderyColor,
                  ),
                  title: Text(
                    quran.getSurahName(widget.surahNumber),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  trailing: typeOfChipMethod(progressOfSurah)),
            ),
          )),
    );
  }
}
