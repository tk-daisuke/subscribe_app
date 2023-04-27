import 'package:bom_app/constants.dart';
import 'package:bom_app/service/analytics_service.dart';
import 'package:flutter/material.dart';

Future<dynamic> CloseDialog(BuildContext context) {
  final _analytics = AnalyticsService();

  return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 5),

          backgroundColor: kPrimaryColor,
          // actionsOverflowButtonSpacing: 48,
          title: const Text('内容を破棄します\nよろしいですか？'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _analytics.sendButtonEvent(buttonName: 'アイテム閉じず続ける');
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text(
                    '編集を続ける',
                    textScaleFactor: kTextScaleFactor,
                    style: TextStyle(
                      color: kTextColor,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kCloseDialogButton,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _analytics.sendButtonEvent(buttonName: 'アイテム編集破棄して閉じる');
                    Navigator.of(dialogContext).pop();
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: kTextColor,
                  ),
                  label: const Text(
                    '破棄する',
                    textScaleFactor: kTextScaleFactor,
                    style: TextStyle(
                      color: kTextColor,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kCloseDialogButton,
                  ),
                ),
              ],
            ),
          ],
        );
      });
}
