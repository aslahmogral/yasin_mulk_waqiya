import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';
import 'package:yasin_mulk_waqiya/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 1;
  final controller = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    controller.addListener(() {
      setState(() {
        _currentPage = controller.page!.toInt();
      });
    });
  }

  Stack appBarArea(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          child: Image.asset('assets/masjid_arc.png'),
        ),
        Positioned(
          bottom: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '36. Ya Seen',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                          ' (${_currentPage + 1}/${quran.getVerseCount(36).toString()})'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> yaseenList() {
    int verseCount = quran.getVerseCount(36);
    int verseLeft = verseCount - _currentPage - 1;
    List<Widget> finalList = [];
    for (int i = 1; i <= verseCount; i++) {
      finalList.add(
        Column(
          children: [
            appBarArea(context),
            SizedBox(height: 16),
            Text('$verseLeft Verses Left'),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 40),
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (_currentPage == 0)
                                             Image.asset('assets/bismillah.png'),
                                          Text(
                                            quran.getVerse(36, i),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.amiri(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 28,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 40),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    return finalList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: yaseenList(),
        physics: NeverScrollableScrollPhysics(), 
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 180,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: AppColors.primaryColor,
                ),
                onPressed: () {
                  controller.previousPage(
                    duration: const Duration(milliseconds: 1),
                    curve: Curves.linear,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.seconderyColor,
                  ),
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  side: BorderSide(color: AppColors.seconderyColor),
                ),
                onPressed: () {
                  // print(yaseenList().length);
                  if (_currentPage != quran.getVerseCount(36)-1) {
                    print(_currentPage);
                    print('continue');
                  } else {
                    print('exit');
                  }
                },
                child: Text(
                  'I AM DONE',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: AppColors.primaryColor,
                ),
                onPressed: () {
                  count++;
                  controller.nextPage(
                    duration: const Duration(milliseconds: 1),
                    curve: Curves.linear,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.seconderyColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
