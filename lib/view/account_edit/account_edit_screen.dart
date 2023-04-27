import 'package:bom_app/constants.dart';
import 'package:bom_app/service/analytics_service.dart';
import 'package:bom_app/service/auth_service.dart';
import 'package:bom_app/view/account_delete/account_delete_screen.dart';
import 'package:bom_app/view/global_widget/app_bar_leading_left.dart';
import 'package:bom_app/view/global_widget/list_container.dart';
import 'package:bom_app/view/global_widget/menu_title.dart';
import 'package:bom_app/view/global_widget/user_button.dart';
import 'package:bom_app/view/account_edit/widget/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountEditScreen extends StatelessWidget {
  static const String id = 'auth_provider_edit_screen';

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    context.read<AuthService>().getProviderInfo();
    final _analytics = AnalyticsService();
    final _isAnonymous = context.read<AuthService>().anonymousUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: AppBarLeadingLeft(
          text: '戻る',
          icon: Icons.arrow_back_ios,
          color: kTextColor,
          onPressed: () {
            Navigator.pop(context);
            _analytics.sendButtonEvent(buttonName: '戻る');
          },
        ),
        leadingWidth: kAppBarLeadingWidth,
        // backgroundColor: kTextColor,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: _size.height * 0.08, bottom: _size.height * 0.001),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              UserProfile(),
              // MenuTitle(sized: _size, title: 'SNS連携'),
              // ListContainer(
              //   sized: _size,
              //   child: SnsLinkMenu(size: _size),
              // ),
              // メールアドレス＆パスワード認証はemailVerified: false,
              // だとGoogleを追加した際に無効になるのでオミット              // EmailUserMenu(size: _size),
              Column(
                children: <Widget>[
                  MenuTitle(title: '', sized: _size),
                  ListContainer(
                    sized: _size,
                    child: Column(
                      children: <Widget>[
                        // Consumer<AuthService>(
                        //     builder: (context, authService, child) {
                        //   return Column(
                        //     children: <Widget>[
                        //       if (!authService.anonymousUser
                        //|| !_isAnonymous)
                        //         UserButton(
                        //           sized: _size,
                        //           text: 'ログアウト',
                        //           onPresse: () {
                        //             showDialog(
                        //                 context: context,
                        //                 builder: (dialogcontext) {
                        //                   _analytics.sendButtonEvent(
                        //                       buttonName: 'ログアウト');
                        //                   return SignoutDialog(
                        //                     maincontext: context,
                        //                   );
                        //                 });
                        //           },
                        //         ),
                        //     ],
                        //   );
                        // }),
                        if (_isAnonymous == false)
                          UserButton(
                            sized: _size,
                            text: 'アカウントを削除する',
                            onPresse: () {
                              _analytics.sendButtonEvent(buttonName: 'アカウント削除');
                              Navigator.pushNamed(
                                  context, AccountDeleteScreen.id);
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              // DevMenu(size: _size),
            ],
          ),
        ),
      ),
    );
  }
}


// if (_googleUser && !_passwordUser)
//   Column(
//     children: <Widget>[
//       Row(
//         children: <Widget>[
// MenuTitle(title: 'パスワードの追加', sized: _size),
// IconButton(
//   onPressed: () {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             contentPadding:
//                 const EdgeInsets.symmetric(
//                     vertical: 10,
// horizontal: 20),
//             backgroundColor: kPrimaryColor,
//             title: Row(
//               mainAxisAlignment:
//                   MainAxisAlignment.center,
//               children: const <Widget>[
//                 Expanded(
//                   child: Text(
//                     'パスワードの追加とは',
//                     style: TextStyle(
//                         color: kTextColor,
//                         fontSize: 15,
//                         fontWeight:
//                             FontWeight.bold),
//                   ),
//                 ),
//                 Padding(
//                     padding:
//
//  EdgeInsets.only(left: 20),
//                     child: FaIcon(
//                         FontAwesomeIcons.user)),
//               ],
//             ),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: const <Widget>[
//                   Text(
//                     'メールアドレスとパスワードで',
//                     style: TextStyle(
//                       color: kTextColor,
//                       fontSize: 12,
//                     ),
//                   ),
//                   Text(
//                     'ログインできるようになります。',
//                     style: TextStyle(
//                       color: kTextColor,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text(
//                   'OK',
//                   style: TextStyle(
//                     color: kTextColor,
//                   ),
//                 ),
//               ),
//             ],
//           );
//         });
//   },
//   icon: Container(
//     child: FaIcon(
//       FontAwesomeIcons.questionCircle,
//       color: Colors.pink,
//     ),
//   ),
// ),
// ],
// ),
// ListContainer(
//   sized: _size,
//   child: UserButton(
//     sized: _size,
//     text: 'パスワードを追加する',
//     onPresse: () {
//       print('aa');
//     },
//   ),
// ),
//   ],
// ),
