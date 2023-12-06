import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:yasin_mulk_waqiya/screens/home_screen/home_screen_model.dart';
import 'package:yasin_mulk_waqiya/utils/colors.dart';
import 'package:yasin_mulk_waqiya/widgets/appbar.dart';
import 'package:yasin_mulk_waqiya/screens/surah_list_tile/surah_list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenModel()),
      ],
      child: Consumer<HomeScreenModel>(builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                MyAppBar(
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                        side: BorderSide(color: AppColors.seconderyColor),
                      ),
                      onPressed: () async {
                        await model.clearProgressButtonClicked();
                      },
                      child: Text('clear Progress'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                SurahListTile(
                  surahNumber: 36,
                ),
                SurahListTile(
                  surahNumber: 67,
                ),
                SurahListTile(
                  surahNumber: 56,
                ),
                SurahListTile(
                  surahNumber: 18,
                ),
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
