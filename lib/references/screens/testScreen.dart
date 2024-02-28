import 'package:flutter/material.dart';
import 'package:quran/quran.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<Widget> finalList = [];  

  @override
  Widget build(BuildContext context) {
    Map juzMap = getSurahAndVersesFromJuz(1); 
    juzMap.forEach((key, value) {
      // finalList.add(Text(basmala) );
      for (int i = value[0]; i <= value[1]; i++) {
        finalList.add( Text(getVerse(key, i)) );
      }
    });
    // List surahsAndVerse = juzMap.forEach()

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [...finalList],
        ),
      ),
    );
  }
}
