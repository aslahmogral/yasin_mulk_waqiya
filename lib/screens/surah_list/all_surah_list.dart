import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_quran/screens/surah_list/surah_list_model.dart';
import 'package:daily_quran/utils/colors.dart';

class AllSurahListScreen extends StatefulWidget {
  const AllSurahListScreen({
    super.key,
  });

  @override
  State<AllSurahListScreen> createState() => _AllSurahListScreenState();
}

class _AllSurahListScreenState extends State<AllSurahListScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SurahListModel()),
      ],
      child: Consumer<SurahListModel>(
          builder: (context, SurahListModel model, child) {
        // model.switchSurahList(widget.index);
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
            child: model.isSurahLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),

                      ...model.dailySurahList
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
