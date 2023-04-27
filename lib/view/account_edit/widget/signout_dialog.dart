// import 'package:bom_app/constants.dart';
// import 'package:bom_app/service/auth_service.dart';
// import 'package:bom_app/view/account_edit/account_edit_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_progress_hud/flutter_progress_hud.dart';
// import 'package:provider/provider.dart';

// class SignoutDialog extends StatelessWidget {
//   const SignoutDialog({
//     Key? key, required this.maincontext,
//   }) : super(key: key);
//   final BuildContext maincontext;
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: const EdgeInsets.symmetric
//(vertical: 10, horizontal: 20),
//       backgroundColor: kPrimaryColor,
//       title: const Text(
//         'ログアウトします',
//         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//       content: SingleChildScrollView(
//         child: ListBody(
//           children: const [
//             const Text(
//               'この操作はやり直せません',
//               textScaleFactor: kTextScaleFactor,
//               style: TextStyle(fontSize: 20),
//             ),
//             const Text(
//               'よろしいですか？',
//               textScaleFactor: kTextScaleFactor,
//               style: TextStyle(fontSize: 20),
//             ),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         //  Row(
//         //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         //               children: <Widget>[
//         //                 ElevatedButton.icon(
//         //                   onPressed: () async {
//         //                     _analytics.sendButtonEvent(
//         //                         buttonName: 'google連携解除');
//         //                     Navigator.of(context).pop();
//         //                     await AccountEditModel()
//         //                         .disconnectWithGoogle(authService);
//         //                   },
//         //                   icon: const Icon(
//         //                     Icons.link_off_outlined,
//         //                     color: kButtonText,
//         //                   ),
//         //                   label: const Text(
//         //                     '連携解除',
//         //                     textScaleFactor: kTextScaleFactor,
//         //                     style: TextStyle(
//         //                       color: kButtonText,
//         //                       fontSize: 18,
//         //                     ),
//         //                   ),
//         //                   style: ElevatedButton.styleFrom(
//         //                     primary: kisValidTrue,
//         //                   ),
//         //                 ),
//         //                 const SizedBox(
//         //                   width: 5,
//         //                 ),
//         //                 ElevatedButton(
//         //                   onPressed: () {
//         //                     _analytics.sendButtonEvent(
//         //                         buttonName: 'google連携解除しない');
//         //                     Navigator.of(context).pop();
//         //                   },
//         //                   child: const Text(
//         //                     '閉じる',
//         //                     textScaleFactor: kTextScaleFactor,
//         //                     style: TextStyle(
//         //                       color: kButtonText,
//         //                     ),
//         //                   ),
//         //                   style: ElevatedButton.styleFrom(
//         //                     primary: kisValidFalse,
//         //                   ),
//         //                 ),
//         //               ],
//         //             ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Flexible(
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: const Icon(
//                   Icons.close,
//                 ),
//                 label: const Text(
//                   'キャンセル',
//                   textScaleFactor: kTextScaleFactor,
//                   style: TextStyle(
//                     color: kButtonText,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   primary: kisValidFalse,
//                 ),
//               ),
//             ),
//             Flexible(
//               child:
//                   Consumer<AuthService>(builder: (context, authS
//ervice, child) {
//                 return ElevatedButton.icon(
//                   icon: const Icon(
//                     Icons.logout,
//                   ),
//                   onPressed: () async {final progress = Progress
// HUD.of(context);
//                     progress!.show();
//                           Navigator.pop(context);
//                           await AccountEditModel()
//                               .logOut(maincontext, authService);
                          
//                         },
//                   label: const Text(
//                     'ログアウト',
//                     textScaleFactor: kTextScaleFactor,
//                     style: TextStyle(
//                       color: kButtonText,
//                       // fontSize: 18,
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     primary: kisValidTrue,
//                   ),
//                 );
//               }),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
