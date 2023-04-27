// import 'package:bom_app/service/auth_service.dart';
// import 'package:bom_app/service/button_controller.dart';
// import 'package:bom_app/view/email_change/email_change_screen.dart';
// import 'package:bom_app/view/global_widget/list_container.dart';
// import 'package:bom_app/view/global_widget/menu_title.dart';
// import 'package:bom_app/view/global_widget/user_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

              // メールアドレス＆パスワード認証はemailVerified: false,
              // だとGoogleを追加した際に無効になるのでオミット


// class EmailUserMenu extends StatelessWidget {
//   const EmailUserMenu({
//     Key? key,
//     required Size size,
//   })  : _size = size,
//         super(key: key);

//   final Size _size;

//   @override
//   Widget build(BuildContext context) {
//     final _firebaseUser = context.read<User?>();
//     return Column(
//       children: <Widget>[
//         Consumer2<AuthService, ButtonController>(
//             builder: (context, authService, buttonController, child) {
//           return Column(
//             children: <Widget>[
//               if (authService.emailUser)
//                 UserButton(
//                   sized: _size,
//                   text: 'メールアドレスを変更する',
//                   enable: buttonController.enableButton,
//                   onPresse: () {
//                     buttonController.buttonDisable();
//                     Navigator.pushNamed(context, EmailChangeScreen.id)
//                         .then((value) => buttonController.buttonActivate());
//                     ;
//                   },
//                 ),
//               if (authService.emailUser)
//                 UserButton(
//                   sized: _size,
//                   text: 'パスワード再設定する',
//                   enable: buttonController.enableButton,
//                   onPresse: () async {
//                     buttonController.buttonDisable();
//                     if (_firebaseUser?.email != null) {
//                       await AuthService()
//                           .sendPasswordReset(
//                               email: _firebaseUser!.email.toString())
//                           .then((value) => 
// buttonController.buttonActivate());
//                     } else {
//                       () {
//                         buttonController.buttonActivate();
//                       };
//                     }
//                   },
//                 ),
//             ],
//           );
//         }),
//         Column(
//           children: <Widget>[
//             MenuTitle(title: '', sized: _size),
//             ListContainer(
//               sized: _size,
//               child: Column(
//                 children: <Widget>[
//                   UserButton(
//                     sized: _size,
//                     text: 'dev current user',
//                     onPresse: () {
//                       print(context.read<User?>());
//                     },
//                   ),
//                   Consumer2<AuthService, ButtonController>(
//                       builder: (context, authService,
// buttonController, child) {
//                     return UserButton(
//                       sized: _size,
//                       text: 'dev provider',
//                       enable: buttonController.enableButton,
//                       onPresse: () async {
//                         buttonController.buttonActivate();
//                         await authService
//                             .getProviderInfo()
//                             .then((value) => buttonController.
// buttonActivate());
//                         ;
//                       },
//                     );
//                   }),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
