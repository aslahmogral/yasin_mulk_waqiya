import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yasin_mulk_waqiya/model/surahmodel.dart';
import 'package:yasin_mulk_waqiya/screens/surah_list/surah_list_screens.dart';
import 'package:yasin_mulk_waqiya/screens/home_screen/home_screen.dart';

late Box box;
Future<void> main() async {
  await Hive.initFlutter();
  box = await Hive.openBox('box');
  box = await Hive.openBox('allSurahBox');
  // Hive.registerAdapter(SurahModelAdapter());
  // await Hive.openBox<SurahModel>('surahBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Daily Quran',
        theme: ThemeData(
          fontFamily: 'Poppins',
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen());
  }
}
