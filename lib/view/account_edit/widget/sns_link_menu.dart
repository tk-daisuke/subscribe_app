// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:bom_app/constants.dart';
// import 'package:bom_app/service/analytics_service.dart';
// import 'package:bom_app/service/auth_service.dart';
// import 'package:bom_app/view/account_edit/account_edit_model.dart';
// import 'package:bom_app/view/account_edit/widget/auth_link_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';

// class SnsLinkMenu extends StatelessWidget {
//   const SnsLinkMenu({
//     Key? key,
//     required this.size,
//   }) : super(key: key);

//   final Size size;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AuthService>(builder: (context, authService, child) {
//       final _analytics = AnalyticsService();

//       return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Flexible(
//               child: const Image(
//                 image: AssetImage('assets/images/google_light.png'),
//               ),
//             ),
//             const Expanded(
//               child: const AutoSizeText(
//                 'Google',
//                 textScaleFactor: kTextScaleFactor,
//                 maxFontSize: 18,
//                 maxLines: 1,
//                 style: const TextStyle(fontSize: 18, color: kTextColor),
//               ),
//             ),
//             if (authService.googleUser)
//               AuthLinkButton(
//                 enable: !authService.loading,
//                 onPressed: () async {
//                   showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           contentPadding: const EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 20),
//                           backgroundColor: kPrimaryColor,
//                           title: SingleChildScrollView(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: const <Widget>[
//                                 Flexible(
//                                   child: Text(
//                                     'Googleアカウント',
//                                     textScaleFactor: kTextScaleFactor,
//                                     style: const TextStyle(
//                                         color: kTextColor,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20),
//                                   ),
//                                 ),
//                                 const Padding(
//                                   padding: const EdgeInsets.only(left: 20),
//                                   child: const Icon(
//                                     Icons.account_circle_rounded,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           content: SingleChildScrollView(
//                             child: ListBody(
//                               children: <Widget>[
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.
//symmetric(horizontal: 5),
//                                   child: Text(
//                                     '${authService.googleEmail}',
//                                     textScaleFactor: kTextScaleFactor,
//                                     style: const TextStyle(
//                                         fontFamily: 'Robot',
//                                         fontSize: 22,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                                 ElevatedButton.icon(
//                                   onPressed: () async {
//                                     _analytics.sendButtonEvent(
//                                         buttonName: 'google連携解除');
//                                     Navigator.of(context).pop();
//                                     await AccountEditModel()
//                                         .disconnectWithGoogle(authService);
//                                   },
//                                   icon: const Icon(
//                                     Icons.link_off_outlined,
//                                     color: kButtonText,
//                                   ),
//                                   label: const Text(
//                                     '連携解除',
//                                     textScaleFactor: kTextScaleFactor,
//                                     style: TextStyle(
//                                       color: kButtonText,
//                                       fontFamily: 'Saira',
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                   style: ElevatedButton.styleFrom(
//                                     primary: kisValidTrue,
//                                   ),
//                                 ),
//                                 const Padding(
//                                   padding:
//                                       const EdgeInsets.
//symmetric(horizontal: 5),
//                                   child: Text(
//                                     '',
//                                     textScaleFactor: kTextScaleFactor,
//                                     style: const TextStyle(
//                                         fontFamily: 'Robot',
//                                         fontSize: 22,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           actions: <Widget>[
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 // const SizedBox(
//                                 //   width: 5,
//                                 // ),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     _analytics.sendButtonEvent(
//                                         buttonName: 'google連携解除しない');
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: const Text(
//                                     '戻る',
//                                     textScaleFactor: kTextScaleFactor,
//                                     style: TextStyle(
//                                       color: kTextColor,
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                   style: ElevatedButton.styleFrom(
//                                     primary: kCloseDialogButton,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         );
//                       });
//                 },
//                 title: '連携中',
//               ),
//             if (authService.googleUser == false)
//               AuthLinkButton(
//                 enable: !authService.loading,
//                 onPressed: () async {
//                   await AccountEditModel().connectingGoogle(authService);
//                 },
//                 title: '連携する',
//               ),
//           ]);
//     });
//   }
// }
