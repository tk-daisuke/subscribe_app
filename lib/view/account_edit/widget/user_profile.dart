import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
import 'package:bom_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Column(children: <Widget>[
      Card(
        shadowColor: kTextColor,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        elevation: 3,
        child: Column(
          children: <Widget>[
            Consumer<AuthService>(builder: (context, authService, child) {
              return Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: const Icon(
                      Icons.account_circle_rounded,
                      color: kTextColor,
                      size: 50,
                    ),
                  ),
                  SizedBox(
                    height: _size.height * 0.01,
                  ),
                  const AutoSizeText(
                    // authService.anonymousUser ? '現在連携なし' :
                    'アカウント管理',
                    textScaleFactor: kTextScaleFactor,
                    style: const TextStyle(
                      color: kTextColor,
                      fontFamily: 'Robot',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: _size.height * 0.01,
                  ),
                  SizedBox(
                    width: _size.width / 1,
                  ),
                  if (kGoogleSignIn)
                    Row(
                      children: <Widget>[
                        // Expanded(child: const),
                        // MenuTitle(sized: _size, title: 'アプリへのログイン'),
                        const SizedBox(
                          width: 50,
                        ),
                        const Flexible(
                            flex: 2,
                            child: const AutoSizeText(
                              'アプリへのログイン',
                              textScaleFactor: kTextScaleFactor,
                              style: const TextStyle(
                                color: kTextColor,
                                fontFamily: 'Robot',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                        Flexible(
                          flex: 1,
                          child: IconButton(
                            icon: const Icon(
                              Icons.help_outline_rounded,
                              color: kTextColor,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const SigninQuestionDialog();
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                  // if (kGoogleSignIn) SnsLinkMenu(size: _size),
                ],
              );
            }),
          ],
        ),
      ),
    ]);
  }
}

class SigninQuestionDialog extends StatelessWidget {
  const SigninQuestionDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      backgroundColor: kPrimaryColor,
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'ログインとは',
              textScaleFactor: kTextScaleFactor,
              style: TextStyle(
                  color: kTextColor, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 20),
              child: const Icon(
                Icons.account_circle_rounded,
              ),
            ),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                'SNS連携をすることでアプリを消しても\nデータを復旧出来ます。',
                textScaleFactor: kTextScaleFactor,
                style: TextStyle(fontSize: 20),
              ),
            ),
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
            textScaleFactor: kTextScaleFactor,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
