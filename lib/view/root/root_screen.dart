// Flutter imports:
import 'package:bom_app/constants.dart';
import 'package:bom_app/service/ad_helper.dart';
import 'package:bom_app/view/account_edit/account_edit_model.dart';
// Project imports:
import 'package:bom_app/view/root/root_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatelessWidget {
  static const String id = 'root_screen';
  @override
  Widget build(BuildContext context) {
    // RootModel().admodCheck().then((value)
    // => RootModel().loginCheck(context));
    // RootModel().loginCheck(context);
    // context.read<AuthService>().loading = false;
    context.read<AccountEditModel>().delete = false;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: FutureBuilder(
          future: AdHelper().admodCheck(),
          builder: (ctx, dataSnapshot) {
            print(dataSnapshot.connectionState);
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              // 非同期処理未完了 = 通信中
              return const Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Loading',
                ),
              );
            }
            RootModel().loginCheck(context);
            return const Center(
              child: CircularProgressIndicator(
                semanticsLabel: 'Loading',
              ),
            );
          }),
    );
    //  Center(
    //   child: CircularProgressIndicator(
    //     semanticsLabel: 'Loading',
    //   ),
    // ),
  }
}


    // final userStream = context.watch<User?>();

    // if (userStream != null) {
    //   Future.delayed(Duration.zero, () {
    //     Navigator.pushReplacementNamed(context, ListScreen.id);
    //   });
    // } else {
    //   Future.delayed(Duration.zero, () {
    //     Navigator.pushReplacementNamed(context, WelcomeScreen.id);
    //   });
    // }
