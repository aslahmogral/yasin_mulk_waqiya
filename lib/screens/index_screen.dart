import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:yasin_mulk_waqiya/screens/surah_widget.dart';
import 'package:quran/quran.dart' as quran;


class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quran'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurahWidget(surahNumber: 36),
                    ));
              },
              child: Text(quran.getSurahName(36))),



          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurahWidget(surahNumber: 67),
                    ));
              },
                            child: Text(quran.getSurahName(67))),


               ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurahWidget(surahNumber: 56),
                    ));
              },
                            child: Text(quran.getSurahName(56))),

        ],
      ),
    );
  }
}
