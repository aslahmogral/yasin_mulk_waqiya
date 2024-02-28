import 'package:daily_quran/references/screens/bottom_nav_bar/bottom_nav_bar_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_quran/utils/colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenModel()),
      ],
      child: Consumer(builder: (context, HomeScreenModel model, child) {
        return Scaffold(
          body: model.screensForBottomNav[model.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: AppColors.primaryColor,
              fixedColor: AppColors.seconderyColor,
              unselectedItemColor: Colors.white.withOpacity(0.5),
              onTap: (index) {
                model.onBottomNavigationTap(index);
              },
              currentIndex: model.currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark), label: 'Favourite Surahs'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.book_sharp,
                    ),
                    label: 'All Surahs')
              ]),
        );
      }),
    );
  }
}
