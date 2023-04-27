import 'package:bom_app/constants.dart';
import 'package:bom_app/service/analytics_service.dart';
import 'package:bom_app/view/user/user_screen.dart';
import 'package:flutter/material.dart';

class ListModel extends ChangeNotifier {
  int totalPriceIndex = 0;

  final kTabs = <Tab>[
    const Tab(
      child: Text('すべて'),
      iconMargin: EdgeInsets.all(0),
    ),
    const Tab(
      child: Text('年'),
    ),
    const Tab(
      child: Text(' 月 '),
    ),
    const Tab(
      child: Text(' 週 '),
    ),
    const Tab(
      child: Text(' 日'),
    ),
  ];

  void AddIndex() {
    if (totalPriceIndex <= 2) {
      totalPriceIndex++;
    } else {
      totalPriceIndex = 0;
    }
    notifyListeners();
  }

  List<Widget> appBarButtons(BuildContext context) {
    final _analytics = AnalyticsService();
    return [
      IconButton(
        onPressed: () {
          _analytics.sendButtonEvent(buttonName: 'ユーザースクリーン');
          Navigator.pushNamed(context, UserScreen.id);
        },
        icon: const Icon(
          Icons.settings,
          color: kTextColor,
        ),
      ),
      // ElevatedButton(
      //   child: Row(
      //     children: const [
      //       const Icon(
      //         Icons.add,
      //         color: kTextColor,
      //       ),
      //       const Text(
      //         '追加',
      //       ),
      //     ],
      //   ),
      //   style: ElevatedButton.styleFrom(
      //     primary: Colors.white,
      //     elevation: 0,
      //     onPrimary: Colors.black,
      //   ),
      //   onPressed: () {
      //     _analytics.sendButtonEvent(buttonName: 'ADDスクリーン');
      //     Navigator.pushNamed(context, AddScreen.id);
      //   },
      // ),
    ];
  }
}
