import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
import 'package:bom_app/item/subscription_item.dart';
import 'package:bom_app/service/calculation_system.dart';
import 'package:bom_app/view/list/widget/subscription/plan_price_info.dart';
import 'package:flutter/material.dart';

class SubscriptionInfo extends StatelessWidget {
  const SubscriptionInfo({Key? key, required this.item}) : super(key: key);

  final SubscriptionItem item;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    // final nextTime = CalculationSystem().nextUpdate(
    //     reloadTime: item.unitNumbar,
    //     startTime: item.startTime,
    //     countValue: item.next_reload);
    final contractDay = CalculationSystem()
        .getContractDay(startTime: item.startTime,);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                ' ${item.name}',
                textScaleFactor: kTextScaleFactor,
                maxFontSize: 22,
                minFontSize: 8,
                maxLines: 1,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.skip_next,
                    color: kTextColor,
                  ),
                  const Expanded(
                    flex: 1,
                    child: AutoSizeText(
                      '契約',
                      maxFontSize: 14,
                      maxLines: 1,
                      textScaleFactor: kTextScaleFactor,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: AutoSizeText(
                      '${contractDay}日目',
                      maxFontSize: 14,
                      textScaleFactor: kTextScaleFactor,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),

              // SubscriptionCell(
              //     icon: Icons.skip_next,
              //     iconcolor: kTextColor,
              //     title: '契約',
              //     contents: '${contractDay}日目'),
            ],
          ),
        ),
        SizedBox(width: _size.width * 0.1),
        Expanded(child: PlanPriceInfo(item: item)),
      ],
    );
  }
}
