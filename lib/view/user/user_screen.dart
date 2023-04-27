// Flutter imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
import 'package:bom_app/service/analytics_service.dart';
import 'package:bom_app/service/url_launch.dart';
import 'package:bom_app/view/account_edit/account_edit_screen.dart';
import 'package:bom_app/view/global_widget/app_bar_leading_left.dart';
import 'package:bom_app/view/global_widget/list_container.dart';
import 'package:bom_app/view/global_widget/menu_title.dart';
import 'package:bom_app/view/global_widget/user_button.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter/widgets.dart';

// Project imports:

class UserScreen extends StatelessWidget {
  static const String id = 'user_screen';

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _urlLaunch = UrlLaunch();
    final _analytics = AnalyticsService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor, elevation: 0,
        leading: AppBarLeadingLeft(
          text: '戻る',
          icon: Icons.arrow_back_ios,
          color: kTextColor,
          onPressed: () {
            Navigator.pop(context);
            _analytics.sendButtonEvent(buttonName: '戻る');
          },
        ),
        // backgroundColor: kTextColor,
        leadingWidth: kAppBarLeadingWidth,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: _size.height * 0.02),
            Column(
              children: <Widget>[
                MenuTitle(title: 'ユーザー', sized: _size),
                ListContainer(
                  sized: _size,
                  child: Column(
                    children: <Widget>[
                      UserButton(
                        sized: _size,
                        text: 'アカウント管理',
                        onPresse: () {
                          Navigator.pushNamed(context, AccountEditScreen.id);
                          _analytics.sendButtonEvent(buttonName: 'アカウント管理');
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: _size.height * 0.01),
                Column(
                  children: <Widget>[
                    MenuTitle(title: 'アプリ', sized: _size),
                    ListContainer(
                        sized: _size,
                        child: Column(
                          children: <Widget>[
                            UserButton(
                              sized: _size,
                              text: 'お問い合わせ・ご要望',
                              onPresse: () {
                                _urlLaunch.launchURL(kQuestionForm);
                                _analytics.sendButtonEvent(
                                    buttonName: 'お問い合わせ・ご要望');
                              },
                            ),
                            UserButton(
                              sized: _size,
                              text: '利用規約',
                              onPresse: () {
                                _urlLaunch.launchURL(kTermsofService);
                                _analytics.sendButtonEvent(buttonName: '利用規約');
                                //
                              },
                            ),
                            UserButton(
                              sized: _size,
                              text: 'プライバシーポリシー',
                              onPresse: () {
                                print('aa');
                                _urlLaunch.launchURL(kPrivacyPolicy);
                                _analytics.sendButtonEvent(
                                    buttonName: 'プライバシーポリシー');
                              },
                            ),
                            UserButton(
                                sized: _size,
                                text: 'ライセンス',
                                onPresse: () {
                                  _analytics.sendButtonEvent(
                                      buttonName: 'ライセンス');
                                  showLicensePage(
                                    context: context,
                                    applicationName: kAppName, // アプリの名前
                                    applicationVersion: kAppVersion, // バージョン
                                    applicationIcon:
                                        Container(), // アプリのアイコン Widget
                                    applicationLegalese:
                                        '2021 Daisuke Sato', // 権利情報
                                  );
                                }),
                            const Divider(),
                            const _appVersion(),
                          ],
                        )),
                    // SizedBox(height: _size.height * 0.03),
                  ],
                ),
                SizedBox(height: _size.height * 0.01),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _appVersion extends StatelessWidget {
  const _appVersion();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        children: [
          SizedBox(
            width: _size.width * 0.04,
          ),
          SizedBox(
            width: _size.width * 0.02,
          ),
          const Expanded(
            child: AutoSizeText('アプリのバージョン' '$kAppVersion',
                textScaleFactor: kTextScaleFactor,
                maxFontSize: 20,
                maxLines: 1,
                style: const TextStyle(fontSize: 20, color: kTextColor)),
          ),
        ],
      ),
    );
  }
}
