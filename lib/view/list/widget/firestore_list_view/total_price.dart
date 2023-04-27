import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
import 'package:bom_app/item/price.dart';
import 'package:bom_app/service/analytics_service.dart';
import 'package:bom_app/view/list/list_model.dart';
import 'package:bom_app/view/list/widget/expanded_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({
    Key? key,
    required this.allPrice,
    required this.priceList,
  }) : super(key: key);

  final Price allPrice;
  final List<Price> priceList;
  @override
  Widget build(BuildContext context) {
    return Consumer<ListModel>(builder: (context, listModel, child) {
      final allPriceList = <String>[
        kNumberFormat.format(allPrice.day),
        kNumberFormat.format(allPrice.week),
        kNumberFormat.format(allPrice.month),
        kNumberFormat.format(allPrice.year),
      ];
      // final allPriceList = <String>[
      //   allPrice.day.toStringAsFixed(2),
      //   allPrice.week.toStringAsFixed(2),
      //   allPrice.month.toStringAsFixed(2),
      //   allPrice.year.toStringAsFixed(2),
      // ];
      final unitList = <String>[
        '1日',
        '1週間',
        '1ヶ月',
        '1年',
      ];
      final index = listModel.totalPriceIndex;

      List<BreakdownPrice> getList(BuildContext context) {
        switch (index) {
          case 0:
            return priceList
                .map((price) => BreakdownPrice(
                      name: price.name,
                      value: price.day,
                      isActive: price.isActive,
                    ))
                .toList();
          case 1:
            return priceList
                .map((price) => BreakdownPrice(
                    name: price.name,
                    value: price.week,
                    isActive: price.isActive))
                .toList();

          case 2:
            return priceList
                .map((price) => BreakdownPrice(
                    name: price.name,
                    value: price.month,
                    isActive: price.isActive))
                .toList();

          case 3:
            return priceList
                .map((price) => BreakdownPrice(
                    name: price.name,
                    value: price.year,
                    isActive: price.isActive))
                .toList();
          default:
            return <BreakdownPrice>[];
        }
      }

      ;
      final _size = MediaQuery.of(context).size;
      final _analytics = AnalyticsService();
      return Column(
        children: [
          SizedBox(
            width: _size.width * 0.9,
            child: Card(
              elevation: 4,
              child: ExpansionTile(
                onExpansionChanged: (boolValue) {
                  _analytics.sendButtonEvent(buttonName: '合計料金開閉');
                },
                trailing: IconButton(
                  iconSize: 30,
                  onPressed: () {
                    _analytics.sendButtonEvent(buttonName: '合計料金切り替え');
                    listModel.AddIndex();
                  },
                  icon: const Icon(
                    Icons.next_plan,
                    color: Colors.blueAccent,
                  ),
                ),
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          const Icon(
                            Icons.update_rounded,
                          ),
                          Flexible(
                            child: AutoSizeText(
                              ' ${unitList[index]}',
                              textScaleFactor: kTextScaleFactor,
                              maxFontSize: 20,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Flexible(
                            child: const AutoSizeText(
                              'の合計 内訳',
                              textScaleFactor: kTextScaleFactor,
                              maxLines: 1,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          // const InfoButton(
                          //   reading: '目安として表示しており保証するものではありません。'
                          //       ' 参考情報としてご活用をお願いします。',
                          // ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: _size.height * 0.01,
                            horizontal: _size.width * 0.155),
                        child: Column(
                          children: [
                            Column(
                              children: getList(context),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.bar_chart,
                      color: kTextColor,
                      size: 20,
                    ),
                    const Expanded(
                      flex: 1,
                      child: const AutoSizeText(
                        '合計',
                        maxFontSize: 15,
                        textScaleFactor: kTextScaleFactor,
                        style: const TextStyle(
                            color: kTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AutoSizeText(
                        ' ${unitList[index]}',
                        textScaleFactor: kTextScaleFactor,
                        maxFontSize: 18,
                        style: const TextStyle(color: kTextColor),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: AutoSizeText(
                        '${allPriceList[index]}円',
                        textScaleFactor: kTextScaleFactor,
                        maxFontSize: 18,
                        style: const TextStyle(
                          color: kTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class BreakdownPrice extends StatelessWidget {
  const BreakdownPrice({
    Key? key,
    required this.name,
    required this.value,
    required this.isActive,
  }) : super(key: key);

  final String name;
  final double value;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AutoSizeText(
                '${name}',
                textScaleFactor: kTextScaleFactor,
                maxLines: 1,
                maxFontSize: 16,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Icon(isActive ? Icons.payments_rounded : Icons.block,
                color: isActive ? Colors.amber : kisValidTrue),
            Expanded(
              child: AutoSizeText(
                isActive ? '${kNumberFormat.format(value)}円' : '無効設定',
                textScaleFactor: kTextScaleFactor,
                maxLines: 5,
                maxFontSize: 16,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const Divider(
            // color: kTextColor,
            ),
      ],
    );
  }
}
