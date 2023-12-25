import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yasin_mulk_waqiya/screens/surah_list/surah_list_model.dart';
import 'package:yasin_mulk_waqiya/utils/colors.dart';

class SurahListScreen extends StatefulWidget {
  final int index;
  const SurahListScreen({super.key, required this.index});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SurahListModel()),
      ],
      child: Consumer<SurahListModel>(
          builder: (context, SurahListModel model, child) {
        model.switchSurahList(widget.index);
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
            actions: [Icon(Icons.more_vert)],
            
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // MyAppBar(
                //   children: [
                //     // OutlinedButton(
                //     //   style: OutlinedButton.styleFrom(
                //     //     shape: StadiumBorder(),
                //     //     side: BorderSide(color: AppColors.seconderyColor),
                //     //   ),
                //     //   onPressed: () async {
                //     //     await model.clearProgressButtonClicked();
                //     //   },
                //     //   child: Text('clear Progress'),
                //     // ),
                //   ],
                // ),
                SizedBox(
                  height: 16,
                ),

                ...model.finalList
                // SurahListTile(
                //   boxName: 'box',
                //   surahNumber: 36,
                // ),
                // SurahListTile(
                //   boxName: 'box',

                //   surahNumber: 67,
                // ),
                // SurahListTile(
                //   boxName: 'box',

                //   surahNumber: 56,
                // ),
                // SurahListTile(
                //   boxName: 'box',

                //   surahNumber: 18,
                // ),
                //  SurahListTile(
                //   surahNumber: 114,
                // ),
                // Expanded(child: SizedBox()),
                // RotatedBox(
                //     quarterTurns: 2,
                //     child: MyAppBar(
                //       children: [],
                //     )),
              ],
            ),
          ),
        );
      }),
    );
  }
}
