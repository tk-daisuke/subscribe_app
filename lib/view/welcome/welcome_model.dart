import 'package:bom_app/service/auth_service.dart';
import 'package:bom_app/service/easy_loading.dart';
import 'package:bom_app/view/root/root_screen.dart';
import 'package:flutter/material.dart';

class WelcomeModel extends ChangeNotifier {
  Future<void> signUp(AuthService authService, BuildContext context) async {
    await authService.anonymousSignup(context);
    if (await authService.isSignIn) {
      Future.delayed(Duration.zero, () {
        EasyLoadingService().showInfo(notificationValue: '登録しました。');
        Navigator.pushNamedAndRemoveUntil(
            context, RootScreen.id, (route) => false);
      });
    } else {
      notifyListeners();
    }
  }

  // Future<void> googleSignUp(
  //     AuthService authService, BuildContext context) async {
  //   notifyListeners();

  //   await authService.signUpWithGoogle();
  //   if (await authService.isSignIn) {
  //     Future.delayed(Duration.zero, () {
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, RootScreen.id, (route) => false);
  //     });
  //   } else {
  //     notifyListeners();
  //   }
  // }
}
