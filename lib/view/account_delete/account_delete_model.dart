import 'package:bom_app/service/analytics_service.dart';
import 'package:bom_app/service/auth_service.dart';
import 'package:bom_app/service/easy_loading.dart';
import 'package:bom_app/view/root/root_screen.dart';
import 'package:flutter/material.dart';

class AccountDeleteModel extends ChangeNotifier {
  bool accountDeleteloading = false;
  Future<void> accountDelete(
      AnalyticsService _analytics,
      AuthService authService,
      BuildContext context,
      EasyLoadingService loading) async {
    _analytics.sendButtonEvent(buttonName: '本当にアカウント削除');
    accountDeleteloading = true;
    notifyListeners();
    await authService.deleteUser(context).onError((error, stackTrace) {
      print('error $error');
      accountDeleteloading = false;
      notifyListeners();
    });
    if (await authService.isSignIn != true) {
      Future.delayed(Duration.zero, () {
        accountDeleteloading = false;
        // Navigator.pop(context);
        loading.showInfo(notificationValue: 'アカウントを削除しました');
        Navigator.pushNamedAndRemoveUntil(
            context, RootScreen.id, (route) => false);
      });
    }
  }
}
