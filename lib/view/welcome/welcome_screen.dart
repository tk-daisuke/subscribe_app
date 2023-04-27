import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
import 'package:bom_app/service/analytics_service.dart';
import 'package:bom_app/service/auth_service.dart';
import 'package:bom_app/service/url_launch.dart';
import 'package:bom_app/view/welcome/welcome_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _analytics = AnalyticsService();
    final _url = UrlLaunch();
    // context.read<AuthService>().loading = false;
    return ProgressHUD(
      child: Scaffold(
        bottomNavigationBar:
            SafeArea(child: _submitCheck(url: _url, analytics: _analytics)),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    _animeTitle(),
                  ],
                ),
              ),
              const AutoSizeText(
                'サブスクリプションを徹底管理',
                minFontSize: 5,
                textScaleFactor: kTextScaleFactor,
                style: TextStyle(fontSize: 20, fontFamily: 'NotoSansJP'),
              ),
              const AutoSizeText(
                '料金を予想しよう',
                minFontSize: 5,
                textScaleFactor: kTextScaleFactor,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: _size.height * 0.04,
              ),
              SizedBox(
                // height: 150,
                width: _size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Consumer2<AuthService, WelcomeModel>(
                        builder: (context, authService, welcome, child) {
                      return ElevatedButton.icon(
                        icon: const Icon(
                          Icons.login,
                          color: kTextColor,
                        ),
                        label: const AutoSizeText(
                          '登録する',
                          textScaleFactor: kTextScaleFactor,
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: kButtonText,
                          // elevation: 4,
                        ),
                        onPressed: () async {
                          final progress = ProgressHUD.of(context);
                          progress!.show();
                          await welcome.signUp(authService, context);
                          progress.dismiss;
                          _analytics.sendButtonEvent(
                              buttonName: 'AnonymousSignUp');
                        },
                      );
                    }),
                    // if (kGoogleSignIn)
                    //   Consumer2<AuthService, WelcomeModel>(
                    //       builder: (context, authService, welcome, child) {
                    //     return SnsButton(
                    //       imagesURL: 'assets/images/google_light.png',
                    //       primaryColor: kPrimaryColor,
                    //       textColor: kTextColor,
                    //       title: 'Googleではじめる',
                    //       onPressed: authService.loading
                    //           ? () async {
                    //               print('mukou');
                    //             }
                    //           : () async {
                    //               await WelcomeModel()
                    //                   .googleSignUp(authService, context);
                    //               _analytics.sendButtonEvent(
                    //                   buttonName: 'Google Start');
                    //             },
                    //     );
                    //   }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _animeTitle extends StatelessWidget {
  const _animeTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: DefaultTextStyle(
        overflow: TextOverflow.clip,
        style: const TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w900,
          color: Colors.black,
          fontFamily: 'NotoSansJp',
        ),
        child: AnimatedTextKit(
          totalRepeatCount: 2,
          // repeatForever: true,
          animatedTexts: [
            WavyAnimatedText('サブスク365'),
            // TypewriterAnimatedText(
            //   '365',
            //   speed: const Duration(milliseconds: 1000),
            // ),
          ],
        ),
      ),
    );
  }
}

class _submitCheck extends StatelessWidget {
  const _submitCheck({
    Key? key,
    required UrlLaunch url,
    required AnalyticsService analytics,
  })  : _url = url,
        _analytics = analytics,
        super(key: key);

  final UrlLaunch _url;
  final AnalyticsService _analytics;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            _url.launchURL(kTermsofService);
            _analytics.sendButtonEvent(buttonName: 'Welcome 利用規約');
          },
          child: const Text(
            '利用規約',
            textScaleFactor: kTextScaleFactor,
            style: TextStyle(
              color: kTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            _url.launchURL(kPrivacyPolicy);
            _analytics.sendButtonEvent(buttonName: 'Welcome プライバシーポリシー');
          },
          child: const Text(
            'プライバシーポリシー',
            textScaleFactor: kTextScaleFactor,
            style: TextStyle(
              color: kTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}

class SnsButton extends StatelessWidget {
  const SnsButton({
    Key? key,
    required this.primaryColor,
    required this.textColor,
    required this.imagesURL,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  final Color primaryColor;
  final Color textColor;
  final String imagesURL;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
          padding: const EdgeInsets.only(top: 3, bottom: 3, left: 3),
        ),
        onPressed: onPressed,
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Image.asset(
                imagesURL,
                height: 30,
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: AutoSizeText(
                  title,
                  textScaleFactor: kTextScaleFactor,
                  maxLines: 1,
                  style:
                      TextStyle(color: textColor, fontWeight: FontWeight.bold),
                )),
          ],
        ));
  }
}
        // padding: EdgeInsets.only(top: 3.0,bottom: 3.0,left: 3.0),
        // color: const Color(0xFF4285F4),