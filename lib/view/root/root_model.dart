// Flutter imports:

import 'package:bom_app/constants.dart';
import 'package:bom_app/service/firestore_service.dart';
import 'package:bom_app/view/list/list_screen.dart';
import 'package:bom_app/view/welcome/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bom_app/service/url_launch.dart';
import 'package:provider/provider.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

class RootModel extends ChangeNotifier {
  final _urlLaunch = UrlLaunch();

  // Future<void> admodCheck() async {
  //   await AppTrackingTransparency.requestTrackingAuthorization();
  // }

  Future<void> loginCheck(BuildContext context) async {
    final _userStream = await FirebaseAuth.instance.authStateChanges();
    print('root${_userStream}');
    final needupdate = await updateCheck(context);
    if (await !needupdate) {
      try {
        print(_userStream);
        if (await _userStream.first != null) {
          Future.delayed(
            Duration.zero,
            () => Navigator.pushReplacementNamed(context, ListScreen.id),
          );
        } else {
          Future.delayed(Duration.zero,
              () => Navigator.pushReplacementNamed(context, WelcomeScreen.id));
        }
      } on Exception catch (e) {
        print(e);
      }
    } else {
      Future.delayed(Duration.zero, () {
        showUpdateDialog(context);
      });
    }
  }

  Future<bool> updateCheck(BuildContext context) async {
    final _package = await PackageInfo.fromPlatform();
    print('appName ${_package.appName}buildNumber ${_package.buildNumber} ');
    print('version ${_package.version}  packageName ${_package.packageName}');

    try {
      final currentVersion = Version.parse(_package.version);
      final version = await context.read<FirestoreService>().appUpdateCheck();
      final newVersion = Version.parse(version.requiredVersion);
      final testVersion = Version.parse(version.testVersion);
      print('currentVersion$currentVersion');
      print('testVersion$testVersion');
      print('fetched value is $newVersion');
      if (newVersion > currentVersion || testVersion > currentVersion) {
        return true;
      }
    } on Exception catch (e) {
      print(e);
    }
    return false;
  }

  void showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        const title = 'バージョン更新のお知らせ';
        const message = '新しいバージョンのアプリが利用可能です。\n お手数ですが、更新をお願い致します。';
        const btnLabel = '今すぐ更新';
        return AlertDialog(
          title: const Text(
            title,
            textScaleFactor: kTextScaleFactor,
          ),
          content: const Text(
            message,
            textScaleFactor: kTextScaleFactor,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Center(
                child: const Text(
                  btnLabel,
                  textScaleFactor: kTextScaleFactor,
                  style: TextStyle(color: kButtonText),
                ),
              ),
              onPressed: () => _urlLaunch.launchURL(kAppstore),
            ),
          ],
        );
      },
    );
    // Platform.isIOS
    //     ? new CupertinoAlertDialog(
    //         title: const Text(title),
    //         content: const Text(message),
    //         actions: <Widget>[
    //           ElevatedButton(
    //             child: const Text(
    //               btnLabel,
    //               style: TextStyle(color: kButtonText),
    //             ),
    //             onPressed: () => _urlLaunch
    //                 .launchURL('https://www.apple.com/jp/app-store/'),
    //           ),
    //         ],
    //       )
    //     : new AlertDialog(
    //         title: const Text(title),
    //         content: const Text(message),
    //         actions: <Widget>[
    //           ElevatedButton(
    //             child: const Text(
    //               btnLabel,
    //               style: TextStyle(color: Colors.red),
    //             ),
    //             onPressed: () => _urlLaunch
    //                 .launchURL('https://www.apple.com/jp/app-store/'),
    //           ),
    //         ],
    //       );
  }
}

// if (await _userStream!.isAnonymous) {
//     Future.delayed(Duration.zero, () {
//       print('isAnonymous');
//       Navigator.pushReplacementNamed(context, ListScreen.id);
//     });
//   } else {
//     if (await _userStream.emailVerified) {
//       Future.delayed(Duration.zero, () {
//         print('メール認証完了です。');
//         Navigator.pushReplacementNamed(context, ListScreen.id);
//       });
//     } else {
//       Future.delayed(Duration.zero, () {
//         print('メール認証が未完了です。');
//         Navigator.pushReplacementNamed(context, VerificationScreen.id);
//       });
//     }
//   }
