import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final List<Widget> children;
  const MyAppBar({super.key,  required this.children, });

  @override
  Widget build(BuildContext context) {
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
                    children: 
                    // [...children]
                    [
                      ...children
                      
                      // Text(
                      //   '${widget.surahNumber}. ${quran.getSurahName(widget.surahNumber)}',
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold, fontSize: 20),
                      // ),
                      // Text(
                      //     ' (${_currentPage + 1}/${quran.getVerseCount(widget.surahNumber).toString()})'),
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
}
