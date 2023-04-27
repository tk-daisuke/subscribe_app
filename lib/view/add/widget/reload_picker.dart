import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
import 'package:bom_app/service/analytics_service.dart';
import 'package:bom_app/view/add/add_model.dart';
import 'package:bom_app/view/add/widget/title_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReloadPicker extends StatelessWidget {
  // final _daysItems = List.generate(31, (index) => '$index');
  // final _monthItems = List.generate(12, (index) => '$index');
  // final _yearsItems = List.generate(10, (index) => '$index');

  @override
  Widget build(BuildContext context) {
    final _analytics = AnalyticsService();
    return Row(
      children: [
        const TitleIcon(
          icon: Icons.autorenew,
        ),
        Consumer<AddModel>(builder: (context, addModel, child) {
          return Flexible(
            child: TextButton(
              onPressed: () {
                addModel.hideKeyboard(context);
                _analytics.sendButtonEvent(buttonName: '追加画面 リロードタイムピッカー');
                addModel.cupertinoPickerDialog(
                  context,
                );
              },
              style: TextButton.styleFrom(),
              child: Row(
                children: [
                  if (addModel.selectUnit != '月')
                    Flexible(
                      child: AutoSizeText(
                        '${addModel.selectDay}${addModel.selectUnit}毎に更新',
                        textScaleFactor: kTextScaleFactor,
                        maxFontSize: 20,
                        style: const TextStyle(
                          fontSize: 20,
                          color: kTextColor,
                        ),
                      ),
                    )
                  else
                    Flexible(
                      child: AutoSizeText(
                        '${addModel.selectDay}ヶ${addModel.selectUnit}毎に更新',
                        textScaleFactor: kTextScaleFactor,
                        maxFontSize: 20,
                        style: const TextStyle(
                          fontSize: 20,
                          color: kTextColor,
                        ),
                      ),
                    ),
                  const Icon(
                    Icons.expand_more_outlined,
                    size: 32,
                    // color: Colors.pinkAccent,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );

    // Column(
    //   children: [
    //     Row(children: <Widget>[
    //       // const TitleIcon(
    //       //   icon: Icons.schedule_sharp,
    //       // ),
    //       // const Expanded(
    //       //   child: AutoSizeText(
    //       //     '更新間隔',
    //       //     style: TextStyle(fontSize: 15),
    //       //   ),
    //       // ),
    //       TextButton(
    //         onPressed: () {
    //           addModel.cupertinoPickerDialog(context, size: _size);
    //         },
    //         child: Row(
    //           children: [
    //             Text('${addModel.selectDay}'),
    //             if (addModel.selectUnit == '月') const Text('ヶ'),
    //             Text('${addModel.selectUnit}'),
    //             const Text('毎に更新'),
    //           ],
    //         ),
    //       )
    //     ]),
    //     // Consumer<AddModel>(
    //     //     builder: (context, addModel, child) {
    //     //   return Text('${addModel.reloadTime.year}/'
    //     //       '${addModel.reloadTime.month}/'
    //     //       '${addModel.reloadTime.day}/');
    //     // }),
    //   ],
    // )
  }
}




    // Column(
      //   children: [
      //     Row(children: <Widget>[
      //       // const TitleIcon(
      //       //   icon: Icons.schedule_sharp,
      //       // ),
      //       // const Expanded(
      //       //   child: AutoSizeText(
      //       //     '更新間隔',
      //       //     style: TextStyle(fontSize: 15),
      //       //   ),
      //       // ),
      //       TextButton(
      //         onPressed: () {
      //           addModel.cupertinoPickerDialog(context, size: _size);
      //         },
      //         child: Row(
      //           children: [
      //             Text('${addModel.selectDay}'),
      //             if (addModel.selectUnit == '月') const Text('ヶ'),
      //             Text('${addModel.selectUnit}'),
      //             const Text('毎に更新'),
      //           ],
      //         ),
      //       )
      //     ]),
      //     // Consumer<AddModel>(
      //     //     builder: (context, addModel, child) {
      //     //   return Text('${addModel.reloadTime.year}/'
      //     //       '${addModel.reloadTime.month}/'
      //     //       '${addModel.reloadTime.day}/');
      //     // }),
      //   ],
      // )
      