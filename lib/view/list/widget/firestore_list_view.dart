import 'package:auto_animated/auto_animated.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
import 'package:bom_app/service/ad_helper.dart';
import 'package:bom_app/service/calculation_system.dart';
import 'package:bom_app/service/firestore_service.dart';
import 'package:bom_app/view/list/list_model.dart';
import 'package:bom_app/view/list/widget/firestore_list_view/total_price.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirestoreListView extends StatelessWidget {
  const FirestoreListView({
    Key? key,
    required this.getItemMethod,
  }) : super(key: key);
  final Future<QuerySnapshot> getItemMethod;

  @override
  Widget build(BuildContext context) {
    const options = LiveOptions(
      delay: Duration(seconds: 0),
      showItemInterval: Duration(milliseconds: 100),
      showItemDuration: Duration(milliseconds: 50),
      visibleFraction: 0.025,
      reAnimateOnVisibility: false,
    );
    return Consumer3<FirestoreService, ListModel, AdHelper>(
        builder: (context, model, listModel, adHelper, child) {
      return FutureBuilder<QuerySnapshot>(
        future: getItemMethod,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            // error
            return const _Issue(
              text: '通信エラーが発生しました',
              text2: '',
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 非同期処理未完了 = 通信中
            return const _Loading();
          }

          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          // サブスクリスト`
            final _subscriptions = model.snapshotList(documents);
          //各料金
          final _eachPrice = model.priceConvert(documents);
          //合計料金
          final _calculation = CalculationSystem();
          final _totalPrice = _calculation.totalPriceResult(_eachPrice);
          final _listScrollController = ScrollController();

          if (_subscriptions.length != 0) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                      color: kPrimaryColor,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            //料金をWidget化
                            TotalPrice(
                              allPrice: _totalPrice,
                              priceList: _eachPrice,
                            ),
                            LiveList.options(
                              options: options,
                              shrinkWrap: true,
                              itemCount: _subscriptions.length,
                              controller: _listScrollController,
                              itemBuilder: (context, index, anime) =>
                                  FadeTransition(
                                opacity: Tween<double>(
                                  begin: 0,
                                  end: 1,
                                ).animate(anime),
                                // And slide transition
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, -0.1),
                                    end: Offset.zero,
                                  ).animate(anime),
                                  // Paste you Widget
                                  child: _subscriptions[index],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 450,
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      const _Issue(
                        text: '登録がありません。',
                        text2: '登録済みで表示されない場合\n「すべて」をタップすると\n表示されます。',
                        child: SizedBox(
                          height: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      );
    });
  }
}

class _Issue extends StatelessWidget {
  const _Issue({
    Key? key,
    this.child = const SizedBox(),
    required this.text,
    required this.text2,
  }) : super(key: key);
  final String text;
  final String text2;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: AutoSizeText(
                text,
                textScaleFactor: kTextScaleFactor,
                maxFontSize: 20,
                maxLines: 3,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            child,
            Flexible(
              child: AutoSizeText(
                text2,
                textScaleFactor: kTextScaleFactor,
                maxFontSize: 19,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 19,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: const CircularProgressIndicator(
        semanticsLabel: 'Loading',
      ),
    );
  }
}

// late BannerAd _ad;

// @override
// void initState() {
//   super.initState();

//   _ad = BannerAd(
//     adUnitId: AdHelper().bannerAdUnitId,
//     size: AdSize.banner,
//     request: const AdRequest(),
//     listener: BannerAdListener(
//       onAdLoaded: (ad) {
//         setState(() {
//           isAdLoaded = true;
//         });
//         print('admod成功');
//       },
//       onAdFailedToLoad: (ad, error) {
//         ad.dispose();
//         print('admod失敗');
//         // Ad failed to load - log the error and dispose the ad.
//       },
//       // Called when an ad opens an overlay that covers the screen.
//       onAdOpened: (Ad ad) => print('Ad opened.'),
//       // Called when an ad removes an overlay that covers the screen.
//       onAdClosed: (Ad ad) => print('Ad closed.'),
//       // Called when an impression occurs on the ad.
//       onAdImpression: (Ad ad) => print('Ad impression.'),
//     ),
//   )..load();
// }

// @override
// void dispose() {
//   _ad.dispose();

//   super.dispose();
// }

// bool isAdLoaded = false;
// final subs = documents.map((doc) {
//   return Subscription(
//     item: model.firestoreConverter(doc),
//   );
// });
// ListView.builder(
//     itemCount: subs.length,
//     itemBuilder: (_, index) {
//       print(subs.toList()[index].item.name);
//       print(subs.toList()[index].item.docID);
//       return subs.toList()[index];
//     }));

// Future<dynamic> _priceDialog(
//     BuildContext context,
//     List<BreakdownPrice> Function(BuildContext context) getList,
//     String unitList) {
//   return showDialog(
//       context: context,
//       builder: (dialogContext) {
//         return AlertDialog(
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//           backgroundColor: kPrimaryColor,
//           title: Row(
//             children: [
//               const Icon(
//                 Icons.analytics,
//               ),
//               Text('${unitList}あたりの内訳'),
//             ],
//           ),
//           content: SingleChildScrollView(
//             child: Column(
//               children: getList(context),
//             ),
//           ),
//           actions: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(dialogContext).pop();
//               },
//               child: const Text(
//                 '閉じる',
//                 style: TextStyle(
//                   color: kTextColor,
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 primary: kisValidFalse,
//               ),
//             ),
//           ],
//         );
//       });
// }

// if (isAdLoaded)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: Container(
//                   child: AdWidget(ad: _ad),
//                   width: _ad.size.width.toDouble(),
//                   height: 100,
//                   alignment: Alignment.center,
//                 ),
//               )
//             else
//               const SizedBox(
//                 height: 110,
//               ),
//             const SizedBox(
//               height: 15,
//             ),
