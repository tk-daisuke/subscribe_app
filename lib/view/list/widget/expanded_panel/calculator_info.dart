import 'package:bom_app/constants.dart';
import 'package:bom_app/item/subscription_item.dart';
import 'package:bom_app/service/calculation_system.dart';
import 'package:bom_app/view/list/widget/expanded_panel/expanded_cell.dart';
import 'package:flutter/material.dart';

class CalculatorInfo extends StatelessWidget {
  CalculatorInfo({
    Key? key,
    required this.item,
    required this.dayTitle,
    required this.weeklyTitle,
    required this.monthlyTitle,
    required this.yearTitle,
    // required this.asFixed,
  }) : super(key: key);

  final CalculationSystem _result = CalculationSystem();
  final SubscriptionItem item;
  final String dayTitle;
  final String weeklyTitle;
  final String monthlyTitle;
  final String yearTitle;
  // final int asFixed;

  @override
  Widget build(BuildContext context) {
    final totalMoney = _result.totalMoney(
        index: item.unitNumber,
        par: item.next_reload,
        price: item.price,
        startTime: item.startTime);
    final result = _result.perMoney(
        price: item.price, index: item.unitNumber, par: item.next_reload);

    return Container(
      child: Column(
        children: [
          ExpandedCell(
              title: dayTitle,
              contents: '${kNumberFormat.format(result.days)}円'),
          ExpandedCell(
              title: weeklyTitle,
              contents: '${kNumberFormat.format(result.weeklys)}円'),
          ExpandedCell(
              title: monthlyTitle,
              contents: '${kNumberFormat.format(result.month)}円'),
          ExpandedCell(
            title: yearTitle,
            contents: '${kNumberFormat.format(result.years)}円',
          ),
          // ExpandedCell(
          //     title: dayTitle,
          //     contents: '${result.days.toStringAsFixed(asFixed)}円'),
          // ExpandedCell(
          //     title: weeklyTitle,
          //     contents: '${result.weeklys.toStringAsFixed(asFixed)}円'),
          // ExpandedCell(
          //     title: monthlyTitle,
          //     contents: '${result.month.toStringAsFixed(asFixed)}円'),
          // ExpandedCell(
          //   title: yearTitle,
          //   contents: '${result.years.toStringAsFixed(asFixed)}円',
          // ),
          if (!totalMoney.isNegative)
            ExpandedCell(
              title: '累計',
              contents: '${kNumberFormat.format(totalMoney)}円',
            )
          else
            const ExpandedCell(
              title: '累計',
              contents: '0円',
            ),
        ],
      ),
    );
  }
}
