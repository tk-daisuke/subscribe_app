import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
import 'package:bom_app/service/analytics_service.dart';
import 'package:bom_app/service/auth_service.dart';
import 'package:bom_app/service/easy_loading.dart';
import 'package:bom_app/view/account_delete/account_delete_model.dart';
import 'package:bom_app/view/global_widget/app_bar_leading_left.dart';
import 'package:bom_app/view/global_widget/list_container.dart';
import 'package:bom_app/view/global_widget/menu_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountDeleteScreen extends StatelessWidget {
  const AccountDeleteScreen({Key? key}) : super(key: key);
  static const String id = 'Account_Delete_screen';

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    // context.read<AuthService>().getProviderInfo();
    final _analytics = AnalyticsService();

    return Consumer<AccountDeleteModel>(builder: (context, deleteModel, child) {
      return AbsorbPointer(
        absorbing: deleteModel.accountDeleteloading,
        child: Scaffold(
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
          ),
          body: Padding(
            padding: EdgeInsets.only(
                top: _size.height * 0.08, bottom: _size.height * 0.001),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  MenuTitle(title: '', sized: _size),
                  ListContainer(
                    sized: _size,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: _size.height * 0.1),
                          child: const AutoSizeText(
                              'アプリに登録した情報が削除され\n復元できなくなります\n'),
                        ),
                        Consumer3<AuthService, EasyLoadingService,
                                AccountDeleteModel>(
                            builder: (context, authService, loading,
                                deleteModel, child) {
                          return ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: kisValidTrue),
                              onPressed: () async {
                                await deleteModel.accountDelete(
                                    _analytics, authService, context, loading);
                                // ;
                              },
                              icon: const Icon(
                                Icons.account_circle,
                              ),
                              label: const Text('削除する'));
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

    // ;
    // await showDialog(
    //     context: context,
    //     builder: (dialogcontext) {
    //       return AccountDeleteDialog(
    //         maincontext: context,
    //       );
    //     });

    // await Future.delayed(Duration.zero, () {});
    // final isDelete =
    //     context.read<Accou
    // ntEditModel>().delete;
    // print(isDelete);
    // if (isDelete) {

    // } else {}

