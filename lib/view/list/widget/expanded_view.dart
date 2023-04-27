import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
import 'package:bom_app/item/subscription_item.dart';
import 'package:bom_app/service/analytics_service.dart';
import 'package:bom_app/service/auth_service.dart';
import 'package:bom_app/service/calculation_system.dart';
import 'package:bom_app/service/firestore_service.dart';
import 'package:bom_app/view/edlit/edit_model.dart';
import 'package:bom_app/view/edlit/edit_screen.dart';
import 'package:bom_app/view/list/widget/expanded_panel/calculator_info.dart';
import 'package:bom_app/view/list/widget/expanded_panel/expanded_cell.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpandedView extends StatelessWidget {
  const ExpandedView({
    Key? key,
    required this.item,
  }) : super(key: key);

  final SubscriptionItem item;

  @override
  Widget build(BuildContext context) {
    final _uid = context.read<AuthService>().currentUserId;
    final _size = MediaQuery.of(context).size;
    final ago = CalculationSystem().getContract(startTime: item.startTime);
    final _analytics = AnalyticsService();

    // final nextUpdate = CalculationSystem().nextUpdate(
    //     reloadTime: item.unitNumber,
    //     startTime: item.startTime,
    //     countValue: item.next_reload);
    final contractDay = CalculationSystem()
        .getContractDay(startTime: item.startTime, );

    return Container(
      color: kPrimaryColor,
      padding: EdgeInsets.symmetric(
          vertical: _size.height * 0.01, horizontal: _size.width * 0.125),
      child: Column(
        children: <Widget>[
          const Divider(),
          const ExpandedPanelTitle(
            icon: Icons.description_outlined,
            title: '推測料金',
          ),
          // const ForecastTitle(
          //   title: '予測料金',
          //   snackText: '目安として表示しており保証するものではありません。参考情報としてご活用をお願いします。',
          // ),
          CalculatorInfo(
            item: item,
            dayTitle: '1日あたり',
            weeklyTitle: '1週間あたり',
            monthlyTitle: '1ヶ月あたり',
            yearTitle: '1年あたり',
          ),
          const Divider(),
          const ExpandedPanelTitle(
            icon: Icons.description_outlined,
            title: 'プラン',
          ),

          ExpandedCell(
            title: '更新間隔',
            contents: (item.unitNumber != 2)
                ? '${item.next_reload}${item.unit}毎の更新'
                : '${item.next_reload}ヶ${item.unit}毎の更新',
          ),
          ExpandedCell(
            title: '契約日',
            contents: '${DateFormat('yy年M月d日').format(item.startTime)}',
          ),
          // ExpandedCell(
          //   title: '更新予定日',
          //   contents:
          //       // ignore: lines_longer_than_80_chars
          //       '${DateFormat('yy年M月d日').
          //format(nextUpdate ?? DateTime.now())}',
          // ),
          ExpandedCell(title: '契約日数', contents: '$contractDay' '日目'),
          if (!ago.contains('日前') && !ago.contains('1分未満前'))
            ExpandedCell(
              title: '',
              contents: '${ago}',
            ),
          if (item.memo != '')
            ExpandedCell(
              title: 'メモ',
              contents: '${item.memo}',
            ),
          const Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(primary: kisValidTrue),
                    onPressed: () async {
                      _analytics.sendButtonEvent(buttonName: 'アイテム削除ダイアログ');
                      await _delete(
                          context: context, title: item.name, uid: _uid);
                      print('delete後');
                      context.read<FirestoreService>().reload();
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                    label: const Flexible(
                      child: const AutoSizeText(
                        '削除',
                        textScaleFactor: kTextScaleFactor,
                        style: TextStyle(fontSize: 17),
                      ),
                    )),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                    ),
                    onPressed: () async {
                      _analytics.sendButtonEvent(buttonName: '編集画面');
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            settings: const RouteSettings(name: EditScreen.id),
                            builder: (context) {
                              // context.read<FirestoreService>().
                              //loading = false;
                              context.read<EditModel>().selectDay =
                                  item.next_reload.toString();
                              context.read<EditModel>().selectUnitNumber =
                                  item.unitNumber;
                              context.read<EditModel>().selectUnit = item.unit;
                              context.read<EditModel>().reloadTime =
                                  item.startTime;
                              context.read<EditModel>().isViewEnable =
                                  item.isViewEnable;
                              context.read<EditModel>().priceValue = item.price;
                              context.read<EditModel>().nameValue = item.name;
                              context.read<EditModel>().memoValue = item.memo;
                              return EditScreen(
                                item: item,
                              );
                            }),
                      );
                      context.read<FirestoreService>().reload();
                    },
                    icon: const Icon(
                      Icons.mode_rounded,
                    ),
                    label: const Flexible(
                      child: const AutoSizeText(
                        '編集する',
                        textScaleFactor: kTextScaleFactor,
                        softWrap: false,
                        style: TextStyle(fontSize: 17),
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _delete(
      {required BuildContext context,
      required String title,
      required String? uid}) {
    final _analytics = AnalyticsService();

    return showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            backgroundColor: kPrimaryColor,
            title: Row(
              children: [
                const Icon(
                  Icons.ondemand_video,
                ),
                Text(title),
              ],
            ),
            content: const Text('削除してもよろしいですか？'),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      _analytics.sendButtonEvent(buttonName: 'アイテム削除キャンセル');
                      Navigator.of(dialogContext).pop();
                    },
                    child: const Text(
                      'キャンセル',
                      style: TextStyle(
                        color: kButtonText,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: kisValidFalse,
                    ),
                  ),
                  Consumer<FirestoreService>(
                      builder: (context, firestore, child) {
                    return ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(primary: kisValidTrue),
                        onPressed: () async {
                          // final progress = ProgressHUD.of(context);
                          // progress!.show();
                          await _firestore_delete(
                              firestore, uid!, _analytics, context);

                          // await Future.delayed(
                          //     Duration.zero, progress.dismiss);

                          // firestore.reload();
                        },
                        icon: const Icon(
                          Icons.delete,
                        ),
                        label: const Text('削除する'));
                  }),
                ],
              ),
            ],
          );
        });
  }

  Future<void> _firestore_delete(FirestoreService firestore, String uid,
      AnalyticsService _analytics, BuildContext context) async {
    Navigator.of(context).pop();
    await firestore.deleteItem(item, uid);
    _analytics.sendButtonEvent(buttonName: 'アイテム削除');
  }
}

class ExpandedPanelTitle extends StatelessWidget {
  const ExpandedPanelTitle({required this.icon, required this.title});
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon),
        AutoSizeText(
          title,
          textScaleFactor: kTextScaleFactor,
          maxFontSize: 18,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class InfoButton extends StatelessWidget {
  const InfoButton({
    Key? key,
    required this.reading,
  }) : super(key: key);
  final String reading;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(reading)));
        final _analytics = AnalyticsService();

        showDialog(
            context: context,
            builder: (dialogContext) {
              return AlertDialog(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                backgroundColor: kButtonText,
                content: Text(reading),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          _analytics.sendButtonEvent(
                              buttonName: '予想料金の注意ダイアログ');
                          Navigator.of(dialogContext).pop();
                        },
                        child: const Text(
                          'OK',
                          textScaleFactor: kTextScaleFactor,
                          style: TextStyle(
                            color: kButtonText,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: kisValidFalse,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            });
      },
      icon: const Icon(
        Icons.info,
        color: Colors.grey,
      ),
    );
  }
}
