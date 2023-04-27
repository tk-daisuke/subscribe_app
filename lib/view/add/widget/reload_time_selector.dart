import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
import 'package:bom_app/service/analytics_service.dart';
import 'package:bom_app/view/add/add_model.dart';
import 'package:bom_app/view/add/widget/title_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReloadTimeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const TitleIcon(
          icon: Icons.schedule_sharp,
        ),
        Consumer<AddModel>(builder: (context, addModel, child) {
          final _analytics = AnalyticsService();
          return Flexible(
            child: TextButton(
              style: TextButton.styleFrom(
                  // side: const BorderSide(width: 0, color: kTextColor),
                  // backgroundColor: Colors.grey[200]
                  ),
              onPressed: () async {
                addModel.hideKeyboard(context);
                _analytics.sendButtonEvent(buttonName: '追加画面 スタートタイムピッカー');
                final picked = await showDatePicker(
                  locale: const Locale('ja'),
                  context: context,
                  initialDate: addModel.reloadTime,
                  firstDate: DateTime(2000, 1, 1),
                  lastDate: DateTime.now().add(const Duration(days: 60)),
                );
                if (picked != null) {
                  // 日時反映
                  addModel.updateTime(picked);
                }

                //   DatePicker.showDatePicker(
                //   context,
                //     showTitleActions: true,
                //     minTime: DateTime(2000, 1, 1),
                //     maxTime: DateTime.now().add(const Duration(days: 10)),
                //     onChanged: (date) {
                //   print('change $date');
                // }, onConfirm: (date) {
                //   addModel.updateTime(date);
                //   print('confirm $date');
                // }, currentTime: DateTime.now(), locale: LocaleType.jp);
              },
              child: Row(
                children: [
                  Flexible(
                    child: AutoSizeText(
                      '登録日 :'
                      '${DateFormat('yyyy年M月d日').format(addModel.reloadTime)}',
                      textScaleFactor: kTextScaleFactor,

                      maxFontSize: 20,
                      // maxLines: 1,
                      style: const TextStyle(
                        color: kTextColor,
                        fontSize: 20,
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
  }
}
