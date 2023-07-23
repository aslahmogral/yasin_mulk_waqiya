import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:yasin_mulk_waqiya/utils/colors.dart';
import 'package:yasin_mulk_waqiya/widgets/appbar.dart';
import 'package:yasin_mulk_waqiya/widgets/surah_list_tile.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyAppBar(
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  side: BorderSide(color: AppColors.seconderyColor),
                ),
                onPressed: () async {
                  Box box = await Hive.openBox('box');

                   print('---------------------');
                  print(box.get('box'));
                  print('---------------------');
                 await box.clear();
                  setState(() {});
                  print('------------2---------');
                  print(box.get('box'));
                  print('---------------------');
                  setState(() {
                    
                  });

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
          Expanded(child: SizedBox()),
          RotatedBox(
              quarterTurns: 2,
              child: MyAppBar(
                children: [],
              )),
        ],
      ),
    );
  }
}
