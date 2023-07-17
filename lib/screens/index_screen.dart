import 'package:flutter/material.dart';
import 'package:yasin_mulk_waqiya/screens/surah_widget.dart';
import 'package:quran/quran.dart' as quran;
import 'package:yasin_mulk_waqiya/utils/colors.dart';
import 'package:yasin_mulk_waqiya/widgets/appbar.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  String progressOfSurah = '';

  Widget typeOfChipMethod(String result) {
    if (result == 'continue') {
      return Chip(
        label: Text(
          'continue',
        ),
        backgroundColor: Colors.yellow,
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyAppBar(),

          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
                onTap: () async {
                  var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SurahWidget(
                          surahNumber: 36,
                        ),
                      ));
                  setState(() {
                    progressOfSurah = result['type'];
                  });
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
                    child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            '36',
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: AppColors.seconderyColor,
                        ),
                        title: Text(
                          quran.getSurahName(36),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        trailing: typeOfChipMethod(progressOfSurah)),
                  ),
                )),
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => SurahWidget(surahNumber: 36),
          //           ));
          //     },
          //     child: Text(quran.getSurahName(36))),

          // ElevatedButton(
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => SurahWidget(surahNumber: 67),
          //           ));
          //     },
          //                   child: Text(quran.getSurahName(67))),

          //      ElevatedButton(
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => SurahWidget(surahNumber: 56),
          //           ));
          //     },
          //                   child: Text(quran.getSurahName(56))),
        ],
      ),
    );
  }
}
