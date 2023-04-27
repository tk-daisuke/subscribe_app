import 'package:bom_app/service/auth_service.dart';
import 'package:bom_app/service/easy_loading.dart';
import 'package:bom_app/view/root/root_screen.dart';
import 'package:flutter/material.dart';

class AccountEditModel extends ChangeNotifier {
  bool delete = false;
  void deleteAccount() {
    delete = true;
    notifyListeners();
  }

  // Future<void> logOut(BuildContext main
  //context, AuthService authService) async {
  //   await authService.signOut();
  //   if (await authService.isSignIn != true) {
  //     Future.delayed(Duration.zero, () {
  //       authService.showInfo(notificationValue: 'ログアウトしました。');
  //       Navigator.pushNamedAndRemoveUntil(
  //           maincontext, RootScreen.id, (route) => false);
  //     });
  //   }
  // }

  Future<void> deleteAnonymous(BuildContext maincontext,
      AuthService authService, EasyLoadingService loading) async {
    await authService.deleteUser(maincontext);
    if (await authService.isSignIn != true) {
      Future.delayed(Duration.zero, () {
        loading.showInfo(notificationValue: 'アカウントを削除しました');
        Navigator.pushNamedAndRemoveUntil(
            maincontext, RootScreen.id, (route) => false);
      });
    }
  }

  // Future<void> disconnectWithGoogle(AuthService authService) async {
  //   await authService.disconnectGoogle();
  //   await authService.getProviderInfo();
  // }

  // Future<void> connectingGoogle(AuthService authService) async {
  //   print(authService.googleUser);
  //   await authService.linkWithGoogle();
  //   ;
  //   authService.providerTypeReset();
  //   await authService.getProviderInfo();
  // }

  // Future<void> deleteAnonymous(
  //     BuildContext maincontext, AuthService authService) async {
  //   await authService.deleteUser();
  //   if (await authService.isSignIn != true) {
  //     Future.delayed(Duration.zero, () {
  //       authService.showInfo(notificationValue: 'アカウントを削除しました');
  //       Navigator.pushNamedAndRemoveUntil(
  //           maincontext, RootScreen.id, (route) => false);
  //     });
  //   }
  // }
  // Future<void> deleteWithGoogle(BuildContext context) async {
  //   // await context.read<AuthService>().signInWithGoogle();
  //   await context.read<AuthService>().deleteGoogle();
  //   if (await context.read<AuthService>().isSignIn == false) {
  //     Future.delayed(Duration.zero, () {
  //       context.read<AuthService>().sho
  //wInfo(notificationValue: 'アカウントを削除しました');
  //       Navigator.pushNamedAndRemoveUntil(
  //           context, RootScreen.id, (route) => false);
  //     });
  //   }
  // }

// ログインProviderを全削除後にアカウント削除等の認証が必要な操作をすると、
// 匿名なのにrequires-recent-loginがスローされる
//
//https://github.com/firebase/firebase-js-sdk/issues/1216
// 匿名でサインインしたユーザーのみが匿名と見なされます。匿名ユーザーが永続的な資格にアップグレードされると、匿名ユーザーは匿名ではなくなります。
  // Future<void> logOutDialog(BuildContext context) async {
  //   dialogLogout(context);
  //   // await ButtonController().threeWaitButton();
  // }

  // Future<void> deleteDialog(BuildContext context) async {
  //   dialogDelete(context);
  //   // await ButtonController().threeWaitButton();
  // }

  // void dialogLogout(BuildContext context) async {}

  // void dialogDelete(BuildContext context) async {}
}
