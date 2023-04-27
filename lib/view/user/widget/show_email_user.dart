import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
import 'package:bom_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowEmailUser extends StatelessWidget {
  const ShowEmailUser({required this.anonymous});
  final bool anonymous;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    // final _firebaseUser = context.read<User?>();
    // final mailChecked = context.read<User?>()?.emailVerified;
    return ListTile(
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: <Widget>[
            const Icon(
              Icons.account_circle_rounded,
              color: kTextColor,
              size: 50,
            ),
            SizedBox(
              height: _size.height * 0.01,
            ),
            Consumer<AuthService>(builder: (context, authService, child) {
              return Column(
                children: const <Widget>[
                  // if (authService.googleUser)
                  SizedBox(
                    width: double.infinity,
                    child: AutoSizeText(
                      'アカウント',
                      // anonymous ? '連携なしアカウント' : 'アカウント',
                      style: const TextStyle(
                        color: kTextColor,
                        fontFamily: 'Robot',
                        fontSize: 20,
                        fontWeight: FontWeight.w100,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
      subtitle: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: const <Widget>[],
        ),
      ),
    );
  }
}

// AutoSizeText(
//   _firebaseUser?.email != null
//       ? ' ${_firebaseUser?.email}'
//       : 'loading',
//   style: const TextStyle(
//     color: kTextColor,
//     fontFamily: 'Robot',
//     fontSize: 15,
//     fontWeight: FontWeight.w100,
//   ),
//   maxLines: 1,
// ),
// if (authService.googleUser && _firebaseUser!.email != null)
// AutoSizeText(
//   _firebaseUser.email != null
//       ? 'Googleアカウントでログインしています'
//       : 'loading',
//   style: const TextStyle(
//     color: kTextColor,
//     fontFamily: 'Robot',
//     fontSize: 15,
//     fontWeight: FontWeight.w100,
//   ),
//   maxLines: 1,
// ),
//   Consumer<AuthService>(builder: (context, authService, child) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         if (authService.emailUser)
//           const AutoSizeText(
//             'メール認証:',
//             style: TextStyle(
//               color: kTextColor,
//             ),
//           ),
//         if (authService.emailUser)
//           mailChecked!
//               ? const FaIcon(
//                   FontAwesomeIcons.checkCircle,
//                   color: Colors.green,
//                 )
//               : const FaIcon(
//                   FontAwesomeIcons.solidQuestionCircle,
//                   color: Colors.pinkAccent,
//                 ),
//       ],
//     );
//   }),
// メールアドレス＆パスワード認証はemailVerified: false,
// だとGoogleを追加した際に無効になるのでオミット
// if (mailChecked == false)
//   const AutoSizeText(
//     'メールのご確認をお願いします',
//     textAlign: TextAlign.left,
//     style: TextStyle(
//       color: kTextColor,
//     ),
//   ),
// if (mailChecked == false) const SizedBox(width: 8),
// if (mailChecked == false)
//   Consumer3<UserModel, AuthService, ButtonController>(builder:
//       (context, userModel, authService,
// buttonController, child) {
//     return Column(
//       children: <Widget>[
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: IconButton(
//                   icon: const FaIcon(
//                     FontAwesomeIcons.syncAlt,
//                     color: Colors.green,
//                   ),
//                   onPressed: buttonController.enableButton
//                       ? () {
//                           userModel.mailCheck(
//                               authService: authService,
//                               context: context,
//                               buttonController:
// buttonController);
//                         }
//                       : () {}),
//             ),
//             Expanded(
//               child: TextButton(
//                   child: const AutoSizeText(
//                     '再送信',
//                   ),
//                   onPressed: buttonController.enableButton
//                       ? () {
//                           userModel.mailPush(
//                               authService: authService,
//                               buttonController:
// buttonController);
//                         }
//                       : () {}),
//             ),
//           ],
//         ),
//       ],
//     );
//   }),
// const SizedBox(width: 8),
