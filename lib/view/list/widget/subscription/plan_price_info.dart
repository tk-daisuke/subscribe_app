import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
import 'package:bom_app/item/subscription_item.dart';
import 'package:flutter/material.dart';

class PlanPriceInfo extends StatelessWidget {
  const PlanPriceInfo({
    Key? key,
    required this.item,
  }) : super(key: key);
  final SubscriptionItem item;
  @override
  Widget build(BuildContext context) {
    // final _size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UnitReload(item: item),
        Row(
          children: [
            const Icon(
              Icons.payments_rounded,
              color: Colors.amber,
            ),
            const Expanded(
              child: const AutoSizeText(
                '料金: ',
                textScaleFactor: kTextScaleFactor,
                minFontSize: 11,
                maxLines: 1,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 2,
              child: AutoSizeText(
                '${item.price.toStringAsFixed(0)}円',
                textScaleFactor: kTextScaleFactor,
                maxFontSize: 15,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        if (!item.isViewEnable)
          Row(
            children: [
              Icon((item.isViewEnable) ? Icons.done : Icons.block,
                  color: (item.isViewEnable) ? Colors.green : kisValidTrue),
              const Expanded(
                child: AutoSizeText(
                  '合計から除外中',
                  maxFontSize: 14,
                  textScaleFactor: kTextScaleFactor,
                ),
              ),
            ],
          )
      ],
    );
  }
}

class UnitReload extends StatelessWidget {
  const UnitReload({
    Key? key,
    required this.item,
  }) : super(key: key);

  final SubscriptionItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.change_circle,
          color: kisValidFalse,
        ),
        const Flexible(
          flex: 1,
          child: const AutoSizeText(
            '更新:',
            maxLines: 1,
            textScaleFactor: kTextScaleFactor,
            // maxFontSize: 11,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        if (item.unitNumber != 2)
          Flexible(
            flex: 2,
            child: AutoSizeText(
              '${item.next_reload}${item.unit}毎',
              textScaleFactor: kTextScaleFactor,
              maxFontSize: 15,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          )
        else
          Flexible(
            flex: 2,
            child: AutoSizeText(
              '${item.next_reload}ヶ${item.unit}毎',
              textScaleFactor: kTextScaleFactor,
              // maxFontSize: 14,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
      ],
    );
  }
}









// Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             // const Icon(
//             //   Icons.change_circle,
//             //   color: Colors.blue,
//             // ),
//             SizedBox(
//               width: 70,
//               child: Row(
//                 children: [
//                   const Icon(
//                     Icons.change_circle,
//                     color: Colors.blue,
//                   ),
//                   AutoSizeText(
//                     '${item.next_reload}',
//                     maxLines: 1,
//                     maxFontSize: 25,
//                     style: const TextStyle(
//                         fontSize: 19, fontWeight: FontWeight.bold),
//                   ),
//                   if (item.unitNumbar == 2)
//                     const AutoSizeText(
//                       'ヶ',
//                       maxLines: 1,
//                       maxFontSize: 25,
//                       style: const TextStyle(
//                           fontSize: 19, fontWeight: FontWeight.bold),
//                     ),
//                   AutoSizeText(
//                     '${item.unit}ごと',
//                     maxLines: 1,
//                     maxFontSize: 25,
//                     style: const TextStyle(
//                         fontSize: 19, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             Row(
//               children: [
//                 const Icon(
//                   Icons.payments_rounded,
//                   color: Colors.amber,
//                 ),
//                 AutoSizeText(
//                   '${item.price}円',
//                   maxLines: 1,
//                   maxFontSize: 25,
//                   style: const TextStyle(
//                     fontSize: 19,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );


    // ElevatedButton(
    //     onPressed: () {
    //       final start = item.startTime;
    //       final now = DateTime.now();
    //       final difference = now.difference(start);
    //       print(difference.inDays);
    //       print(start.isAfter(now));
    //       print(start.isBefore(now));
    //     },
    //     child: Text('data')),
    // final nextTime = CalculationSystem().nextUpdate(
    //     reloadTime: item.unitNumber,
    //     startTime: item.startTime,
    //     countValue: item.next_reload);
        // SubscriptionCell(
        //   icon: const Icon(
        //     Icons.shopping_cart_outlined,
        //   ),
        //   title: '',
        //   contents:
        //       // ignore: lines_longer_than_80_chars
        //       '${DateFormat('yy年M月d日').format(nextTime ?? DateTime.now())}',
        // ),
        // SubscriptionCell(
        //   icon: const Icon(
        //     Icons.payments_rounded,
        //     color: Colors.amber,
        //   ),
        //   title: '次回: ',
        //   contents: '${nextUpdate.add(duration)}円',
        // ),