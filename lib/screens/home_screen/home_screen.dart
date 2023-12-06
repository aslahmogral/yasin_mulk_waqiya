import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yasin_mulk_waqiya/screens/home_screen/home_screen_model.dart';
import 'package:yasin_mulk_waqiya/utils/colors.dart';
import 'package:yasin_mulk_waqiya/widgets/appbar.dart';
import 'package:yasin_mulk_waqiya/screens/surah_card/surah_list_tile.dart';

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
                SurahCard(
                  surahNumber: 36,
                ),
                SurahCard(
                  surahNumber: 67,
                ),
                SurahCard(
                  surahNumber: 56,
                ),
                SurahCard(
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
