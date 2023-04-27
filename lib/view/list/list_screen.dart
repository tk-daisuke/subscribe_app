import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
// import 'package:bom_app/service/ad_helper.dart';
import 'package:bom_app/service/analytics_service.dart';
import 'package:bom_app/service/auth_service.dart';
import 'package:bom_app/service/firestore_service.dart';
import 'package:bom_app/view/add/add_model.dart';
import 'package:bom_app/view/add/add_screen.dart';
import 'package:bom_app/view/list/list_model.dart';
import 'package:bom_app/view/list/widget/firestore_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatelessWidget {
  static const String id = 'list_screen';
  @override
  Widget build(BuildContext context) {
    final _kTabs = ListModel().kTabs;
    final _appBarButtons = ListModel().appBarButtons;
    final _uid = context.read<AuthService>().currentUserId;
    final _analytics = AnalyticsService();

    // final _bottom = MediaQuery.of(context).padding.bottom;

    return ProgressHUD(
      child: DefaultTabController(
        length: _kTabs.length,
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              _analytics.sendButtonEvent(buttonName: 'ADDスクリーン');
              // context.read<FirestoreService>().loading = false;
              context.read<AddModel>().selectDay = '1';
              context.read<AddModel>().selectUnit = '月';
              context.read<AddModel>().selectUnitNumber = 2;
              context.read<AddModel>().reloadTime = DateTime.now();
              await Navigator.pushNamed(context, AddScreen.id);
              context.read<FirestoreService>().reload();
            },
            child: const Icon(Icons.edit),
          ),
          appBar: AppBar(
            title: Row(
              children: const [
                // Icon(
                //   Icons.ad_units,
                //   color: Colors.red,
                // ),
                SizedBox(
                  // height: 25,
                  width: 25,
                  child: Image(
                    image: AssetImage('assets/images/splash.png'),
                  ),
                ),
                const AutoSizeText(
                  kAppName,
                  style: const TextStyle(
                    fontSize: 17,
                    color: kTextColor,
                    fontFamily: 'NotoSansJp',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            bottom: TabBar(
              indicatorColor: Colors.lightBlue,
              isScrollable: true,
              labelColor: Colors.blue,
              unselectedLabelColor: kTextColor,
              tabs: _kTabs,
            ),
            elevation: 0,
            backgroundColor: kPrimaryColor,
            actions: _appBarButtons(context),
          ),
          body: SafeArea(
            child: Consumer<FirestoreService>(
                builder: (context, firestore, child) {
              return TabBarView(
                children: [
                  FirestoreListView(
                    getItemMethod: firestore.getSubscribes(_uid!),
                  ),
                  FirestoreListView(
                    getItemMethod: firestore.getSqueezeSubscribes(_uid, '年'),
                  ),
                  FirestoreListView(
                    getItemMethod: firestore.getSqueezeSubscribes(_uid, '月'),
                  ),
                  FirestoreListView(
                    getItemMethod: firestore.getSqueezeSubscribes(_uid, '週'),
                  ),
                  FirestoreListView(
                    getItemMethod: firestore.getSqueezeSubscribes(_uid, '日'),
                  ),
                ],
              );
            }),
          ),

          // /TODO ADMOD
          // bottomNavigationBar: FutureBuilder(
          //     future: AdHelper().admodCheck(),
          //     builder: (ctx, dataSnapshot) {
          //       print(dataSnapshot.connectionState);
          //       if (dataSnapshot.connectionS
          //tate == ConnectionState.waiting) {
          //         // 非同期処理未完了 = 通信中
          //         return Padding(
          //           padding: EdgeInsets.only(bottom: _bottom),
          //           child: const SizedBox(
          //             height: kAdmodHeight,
          //           ),
          //         );
          //       }
          //       return Padding(
          //         padding: EdgeInsets.only(bottom: _bottom),
          //         child: const SizedBox(
          //           height: kAdmodHeight,
          //         ),
          //       );
          //     }),
        ),
      ),
    );
  }
}

// class _AdMod extends StatefulWidget {
//   const _AdMod({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _AdModState createState() => _AdModState();
// }

// class _AdModState extends State<_AdMod> {
//   late BannerAd _ad;

//   @override
//   void initState() {
//     super.initState();
//     print('ad loading');

//     _ad = BannerAd(
//       adUnitId: AdHelper().bannerAdUnitId,
//       size: AdSize.banner,
//       request: const AdRequest(),
//       listener: BannerAdListener(
//         onAdLoaded: (ad) async {
//           await AdHelper().admodCheck();
//           setState(() {
//             isAdLoaded = true;
//           });
//           print('admod成功');
//         },
//         onAdFailedToLoad: (ad, error) {
//           ad.dispose();
//           print('admod失敗');
//           // Ad failed to load - log the error and dispose the ad.
//         },
//         // Called when an ad opens an overlay that covers the screen.
//         onAdOpened: (Ad ad) =>
//             _analytics.sendButtonEvent(buttonName: 'admod open'),
//         // Called when an ad removes an overlay that covers the screen.
//         onAdClosed: (Ad ad) {
//           _analytics.sendButtonEvent(buttonName: 'admod closed');
//         },
//         // Called when an impression occurs on the ad.
//         onAdImpression: (Ad ad) => print('Ad impression.'),
//       ),
//     );
//     _ad.load();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _ad.dispose();
//     print('_ad破棄');
//   }

//   bool isAdLoaded = false;
//   final _analytics = AnalyticsService();

//   @override
//   Widget build(BuildContext context) {
//     final bottom = MediaQuery.of(context).padding.bottom;

//     return Stack(
//       alignment: AlignmentDirectional.center,
//       children: [
//         if (isAdLoaded)
//           Padding(
//             padding: EdgeInsets.only(bottom: bottom),
//             child: Container(
//               // padding: const EdgeInsets.symmetric(vertical: 10),
//               child: AdWidget(ad: _ad),
//               width: _ad.size.width.toDouble(),
//               height: kAdmodHeight,
//               alignment: Alignment.center,
//             ),
//           )
//         else
//           Padding(
//             padding: EdgeInsets.only(bottom: bottom),
//             child: const SizedBox(
//               height: kAdmodHeight,
//             ),
//           ),
//       ],
//     );
//   }
// }


        // padding: EdgeInsets.only(
        //     top: _size.height * 0.08, bottom: _size.height * 0.001),