import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';
import 'package:yasin_mulk_waqiya/utils/colors.dart';
import 'package:yasin_mulk_waqiya/widgets/button.dart';

class SurahWidget extends StatefulWidget {
  final surahNumber;
  final previousVerse;
  const SurahWidget({Key? key, required this.surahNumber, this.previousVerse})
      : super(key: key);

  @override
  _SurahWidgetState createState() => _SurahWidgetState();
}

class _SurahWidgetState extends State<SurahWidget> {
  int previousVerse = 0;

  int count = 1;
  PageController controller = PageController(initialPage:0 );
  int _currentPage = 0;

  @override
void initState() {
  super.initState();

  if (widget.previousVerse != null) {
    _currentPage = widget.previousVerse;
  }

  controller = PageController(initialPage: _currentPage);

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
                        '${widget.surahNumber}. ${quran.getSurahName(widget.surahNumber)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                          ' (${_currentPage + 1}/${quran.getVerseCount(widget.surahNumber).toString()})'),
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

  List<Widget> AyahList() {
    int verseCount = quran.getVerseCount(widget.surahNumber);
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
                                            quran.getVerse(
                                                widget.surahNumber, i),
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
        children: [...AyahList()],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 180,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _currentPage == 0
                  ? SizedBox(
                      width: 50,
                    )
                  : QButton(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.seconderyColor,
                      ),
                      onPressed: () {
                        controller.previousPage(
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.linear,
                        );
                      },
                    ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  side: BorderSide(color: AppColors.seconderyColor),
                ),
                onPressed: () {
                  // print(yaseenList().length);
                  if (_currentPage !=
                      quran.getVerseCount(widget.surahNumber) - 1) {
                    print(_currentPage);
                    print('continue');
                    Navigator.pop(
                      context,
                      {"type": "continue", "verses": _currentPage},
                    );
                  } else {
                    print('exit');
                    Navigator.pop(context, {"type": "completed"});
                  }
                },
                child: Text(
                  'I AM DONE',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
              _currentPage == quran.getVerseCount(widget.surahNumber) - 1
                  ? SizedBox(
                      width: 50,
                    )
                  : QButton(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.seconderyColor,
                      ),
                      onPressed: () {
                        print(_currentPage);

                        controller.nextPage(
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.linear,
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
