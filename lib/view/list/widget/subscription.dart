import 'package:bom_app/item/subscription_item.dart';
import 'package:bom_app/service/analytics_service.dart';
import 'package:bom_app/view/list/widget/expanded_view.dart';
import 'package:bom_app/view/list/widget/subscription/subscription_info.dart';
import 'package:flutter/material.dart';

class Subscription extends StatelessWidget {
  const Subscription({
    required this.item,
  });

  final SubscriptionItem item;

  @override
  Widget build(BuildContext context) {
    // final contractDay = CalculationSystem()
    //     .getContractDay(startTime: item.startTime,
    // unitNumbar: item.unitNumbar);
    final _analytics = AnalyticsService();
    if (item.isEnable) {
      return Card(
        elevation: 1,
        child: ExpansionTile(
          onExpansionChanged: (boolValue) {
            _analytics.sendButtonEvent(buttonName: 'アイテム開閉');
          },
          title: SubscriptionInfo(
            item: item,
          ),
          children: <Widget>[
            ExpandedView(
              item: item,
            ),
          ],
        ),
      );
    } else {
      return const Text('アプリのアップデートをお願い致します');
    }
  }
}
