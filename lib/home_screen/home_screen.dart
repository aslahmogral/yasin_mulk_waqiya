import 'package:daily_quran/home_screen/home_screen_model.dart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          'Khathmul Quran',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.seconderyColor),
        ),
        actions: [
          // Consumer<JuzProgressProvider>(
          //     builder: (context, juzProgressModel, child) {
          //   return IconButton(
          //       onPressed: () {
          //         juzProgressModel.resetAllJuzProgress();
          //       },
          //       icon: Icon(Icons.reset_tv));
          // }),
          // Icon(Icons.more_vert),
        ],
      ),
      body: Consumer<HomeScreenModel>(
          builder: (context, juzProgressModel, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                Row(
                  children: [
                  ElevatedButton(onPressed: (){
                    juzProgressModel.prevMonthYear();
                  }, child: Text('prev')),
                  Text(juzProgressModel.currentMonthYear),
                  ElevatedButton(onPressed: (){
                    juzProgressModel.nextMonthYear();
                  }, child: Text('next'))
                ]),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        4, // You can adjust the number of columns as needed
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                  ),
                  itemCount: juzProgressModel.juzList.length,
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // to prevent scrolling of GridView within SingleChildScrollView
                  itemBuilder: (context, index) {
                    return GridTile(
                      child: Container(
                        // Your content for each grid item here
                        child: juzProgressModel.juzList[
                            index], // Replace YourWidget with your actual widget
                      ),
                    );
                  },
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.primaryColor),
                    ),
                    onPressed: () {
                      resetButtonClicked(context, juzProgressModel);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'RESET',
                          style: TextStyle(
                              color: AppColors.seconderyColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<dynamic> resetButtonClicked(
      BuildContext context, HomeScreenModel model) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(builder: (thisLowerContext, innerSetState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                        value: model.shouldReset,
                        onChanged: (val) {
                          innerSetState(() {
                            model.updateShouldReset(val!);
                          });
                        }),
                    Column(
                      children: [
                        Text('Are you Sure '),
                        Text('You Want to Reset ???')
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                // Consumer<JuzProgressProvider>(
                //     builder: (context, juzProgressModel, child) {
                //   return
                Column(
                  children: [
                    Visibility(
                      visible: !model.shouldReset,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.seconderyColor),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Close',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: model.shouldReset,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.primaryColor),
                        ),
                        onPressed: () {
                          if (model.shouldReset) {}
                          model.resetAllJuzProgress();
                          innerSetState(() {
                            model.updateShouldReset(false);
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          'RESET',
                          style: TextStyle(
                              color: AppColors.seconderyColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
                // })
              ],
            );
          }),
        );
      },
    );
  }
}
