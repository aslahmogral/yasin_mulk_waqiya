import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 1;

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
                            child: SizedBox()), //add remaining verse section
                      ],
                    )))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        appBarArea(context),
        Expanded(
          flex: 3,
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
                                    count == 1
                                        ? Text(quran.basmala,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.amiri(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 28,
                                              color: Colors.red
                                            ))
                                        : SizedBox(),
                                    Text(quran.getVerse(36, count),
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
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: () {}, child: Text('<--')),
              ElevatedButton(onPressed: () {}, child: Text('i am done')),
              ElevatedButton(
                  onPressed: () {
                    count++;
                    setState(() {
                      
                    });
                  },
                  child: Text('-->'))
            ],
          ),
        )
      ],
    ));
  }
}
