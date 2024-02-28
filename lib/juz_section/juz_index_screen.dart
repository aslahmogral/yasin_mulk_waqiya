import 'package:daily_quran/juz_section/juz_card/juz_card.dart';
import 'package:daily_quran/juz_section/juz_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_quran/references/screens/surah_index_screen/surah_index_model.dart';
import 'package:daily_quran/utils/colors.dart';

class JuzIndexScreen extends StatefulWidget {
  const JuzIndexScreen({
    super.key,
  });

  @override
  State<JuzIndexScreen> createState() => _JuzIndexScreenState();
}

class _JuzIndexScreenState extends State<JuzIndexScreen> {
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
            actions: [
              Consumer<JuzProgressProvider>(
                  builder: (context, juzProgressModel, child) {
                return IconButton(
                    onPressed: () {
                      juzProgressModel.resetAllJuzProgress();
                    },
                    icon: Icon(Icons.reset_tv));
              }),
              Icon(Icons.more_vert),
            ],
          ),
          body: SingleChildScrollView(
            child: model.isSurahLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            4, // You can adjust the number of columns as needed
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 1.0,
                      ),
                      itemCount: model.juzList.length,
                      shrinkWrap: true,
                      physics:
                          NeverScrollableScrollPhysics(), // to prevent scrolling of GridView within SingleChildScrollView
                      itemBuilder: (context, index) {
                        return GridTile(
                          child: Container(
                            // Your content for each grid item here
                            child: model.juzList[
                                index], // Replace YourWidget with your actual widget
                          ),
                        );
                      },
                    ),
                  ),
          ),
        );
      }),
    );
  }
}
