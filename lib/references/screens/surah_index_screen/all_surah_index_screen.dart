import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_quran/references/screens/surah_index_screen/surah_index_model.dart';
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
          body: model.isSurahLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(), // Disable GridView scrolling
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: model.dailySurahList.length,
                    itemBuilder: (context, index) {
                      return model.dailySurahList[index];
                    },
                  ),
                ),
        );
      }),
    );
  }
}

