// Project imports:
import 'package:bom_app/constants.dart';
import 'package:flutter/material.dart';


class UserModel  {


  // Future<void> mailCheck(
  //     {required AuthService authService,
  //     required BuildContext context,}) async {
  //   //連打対策
  //   await authService
  //       .reloadUserData();
  //   if (await context.read<User?>()!.emailVerified) {
  //     Future.delayed(Duration.zero, () {
  //       authService.showInfo(notificationValue: '確認に成功しました');
  //     });
  //   } else {
  //     dialogA(context);
  //   }
  // }
              // メールアドレス＆パスワード認証はemailVerified: false,
              // だとGoogleを追加した際に無効になるのでオミット
  // Future<void> mailPush(
  //     {required AuthService authService,
  //     required ButtonController buttonController}) async {
  //   buttonController.buttonDisable();
  //   await authService.pushEmail();
  //   //連打対策
  //   await Future.delayed(const Duration(seconds: 7))
  //       .then((value) => buttonController.buttonActivate());
  //   ;
  // }

  void dialogA(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            backgroundColor: kPrimaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  'ご確認',
                  style:
                      TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
                ),
                const Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: const Icon(
  Icons.account_circle_rounded,
),),
              ],
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('認証が完了しておりません。'),
                  Text('メール内のリンクを開くと認証が完了します。'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: kTextColor,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
