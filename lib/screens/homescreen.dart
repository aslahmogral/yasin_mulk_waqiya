import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';
import 'package:yasin_mulk_waqiya/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 1;
  final controller = PageController(initialPage: 0);

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   getWirdData();
    // });
    _currentPage = 0;
    controller.addListener(() {
      setState(() {
        _currentPage = controller.page!.toInt();
        // print(_currentPage);
      });
    });
  }

  Stack appBarArea(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          child: Image.asset(
            'assets/masjid_arc.png',
          ),
        ),
        Positioned(
            bottom: 0,
            child: SizedBox(
                // width: MediaQuery.of(context).size.width / 2.3,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            // child: Image.asset('assets/bismillah.png')),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '36. Ya Seen',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                    '${_currentPage + 1}/${quran.getVerseCount(36).toString()}')
                              ],
                            )), //add remaining verse section
                      ],
                    )))),
      ],
    );
  }

  List yaseenList() {
    int verseLeft = quran.getVerseCount(36) - _currentPage - 1;
    List finalList = [];
    for (int i = 1; i <= quran.getVerseCount(36 - 1); i++) {
      finalList.add(Column(
        children: [
          appBarArea(context),
          SizedBox(
            height: 16,
          ),
          Text('$verseLeft Verses Left'),
          SizedBox(
            height: 16,
          ),
          Expanded(
            // flex: 3,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
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
                                      _currentPage == 0
                                          ? Text(quran.basmala,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.amiri(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 28,
                                                  color: Colors.red))
                                          : SizedBox(),
                                      Text(quran.getVerse(36, i),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.amiri(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28,
                                          ))
                                    ],
                                  ),
                                ),
                                // const SizedBox(
                                //   height: 30,
                                // ),
                                // // Text(
                                //   '(${element.rep} times)',
                                //   style: const TextStyle(
                                //       color: Colors.red, fontWeight: FontWeight.bold),
                                // )
                              ],
                            ),
                          ),
                        ),
                      )),
                      const SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ));
    }
    return finalList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [...yaseenList()],
      ),

      //     Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(16.0),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     ElevatedButton(onPressed: () {}, child: Text('<--')),
      //     ElevatedButton(
      //         onPressed: () {
      //           print(yaseenList());
      //         },
      //         child: Text('i am done')),
      //     ElevatedButton(
      //         onPressed: () {
      //           count++;
      //           setState(() {});
      //         },
      //         child: Text('-->'))
      //   ],
      // ),
      // )
      //   ],
      // )
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
                      backgroundColor: AppColors.primaryColor),
                  onPressed: () {
                    controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.seconderyColor,
                    ),
                  )),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: StadiumBorder(),
                      side: BorderSide(color: AppColors.seconderyColor)),
                  onPressed: () {
                    print(yaseenList());
                    if (_currentPage != quran.getVerseCount(36)) {
                      print('continue');
                    } else {
                      print('exit');
                    }
                  },
                  child: Text(
                    'I AM DONE',
                    style: TextStyle(color: AppColors.primaryColor),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: AppColors.primaryColor),
                  onPressed: () {
                    count++;
                    controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.seconderyColor,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
