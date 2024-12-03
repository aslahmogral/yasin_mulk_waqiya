import 'package:daily_quran/home_screen/home_screen_model.dart.dart';
import 'package:daily_quran/home_screen/home_screen.dart';
import 'package:daily_quran/utils/theme.dart';

import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

// late Box box;
Future<void> main() async {
  // await Hive.initFlutter();
  // box = await Hive.openBox('box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenModel()),
      ],
      child: MaterialApp(
          title: 'Daily Quran',
          theme: customTheme.darkTheme,
          // home: BottomNavBar()),
          // home: TestScreen()),
          home: JuzIndexScreen()),
    );
  }
}
