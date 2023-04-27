// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:bom_app/constants.dart';
import 'package:bom_app/service/easy_loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

// Project imports:

// ProviderID List
// EmailAuthProviderID: password
// PhoneAuthProviderID: phone
// GoogleAuthProviderID: google.com
// FacebookAuthProviderID: facebook.com
// TwitterAuthProviderID: twitter.com
// GitHubAuthProviderID: github.com
// AppleAuthProviderID: apple.com
// YahooAuthProviderID: yahoo.com
// // MicrosoftAuthProviderID: hotmail.com

// 一度にリンクできるアカウントは 2 つだけです。
// すでに他のアカウントとリンクされているアカウントをリンクしようとすると、元のリンクが置き換えられます。
// 新しいアカウントは既存のアカウントとリンクできます。つまり、2 つの既存のアカウントを統合することはできません。
// 2つの同じ認証プロバイダーベースのアカウントをリンクすることはできません。

// メールアドレス確認済みであれば、ログインした時に追加の認証プロバイダが自動でリンクされていくので、以降はどの認証方法でもログインできるようになる。
// メールアドレス未確認だと別の認証方法でログインした時点でその認証方法で上書きになるので、以降はパスワードを使ってログインすることができなくなる。
// ↑[同一のメールアドレスを使用して複数のアカウントを作成できないようにします]の場合のみ？

class AuthService extends ChangeNotifier {
  AuthService(
    this._auth,
  );
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final EasyLoadingService _loading = EasyLoadingService();
  Stream<User?> get authStateChanges => _auth.idTokenChanges();
  bool anonymousState = false;
  bool emailUser = false;
  bool googleUser = false;
  bool anonymousUser = false;
  // bool loading = false;
  String googleEmail = '';

  void firebaseErrorSelector(FirebaseAuthException e) {
    var _infoText = '';
    switch (e.code) {
      case 'requires-recent-login':
        _infoText = 'この操作をするには再認証が必要です';
        break;
      case 'missing-email':
        _infoText = 'メールアドレスに問題があります';
        break;
      case 'email-already-in-use':
        _infoText = 'そのメールアドレスは既に存在します';
        break;
      // case 'weak-password':
      //   infoText = '脆弱なパスワードです';
      //   break;
      case 'sign_in_canceled':
        _infoText = 'キャンセルしました';
        break;
      case 'error-invalid-email':
        _infoText = 'メールアドレスの形式が間違っています';
        break;
      case 'missing-email':
        _infoText = 'そのメールのアカウントは既に存在します';
        break;
      case 'user-not-found':
        _infoText = 'そのアカウントは存在しません';
        break;
      case 'requires-recent-login':
        _infoText = 'この操作をするには再認証が必要です';
        break;
      case 'network-request-failed':
        _infoText = '接続が切れました';
        break;
      case 'too-many-requests': //異常なアクティビティが原因
        _infoText = '接続エラー';
        break;
      case 'credential-already-in-use':
        _infoText = 'この資格情報は、すでに別のユーザーアカウントに関連付けられています。';
        break;
    }
    _loading.showInfo(notificationValue: _infoText);
    notifyListeners();
    print(e);
  }

// admin
  Future<void> getProviderInfo() async {
    emailUser = false;
    googleUser = false;
    anonymousUser = false;
    try {
      if (await _auth.currentUser?.providerData.length != 0) {
        if (_auth.currentUser?.providerData != null) {
          for (final userInfo in await _auth.currentUser!.providerData) {
            switch (userInfo.providerId) {
              case 'google.com':
                print('Sign-in provider: ${userInfo.providerId}');
                print('Provider-specific UID: ${userInfo.uid}');
                print('Name: ${userInfo.displayName}');
                print('Email: ${userInfo.email}');
                print('Photo URL: ${userInfo.photoURL}');
                googleUser = true;
                googleEmail = userInfo.email!;
                print('ProviderType: Google');
                break;
              case 'password':
                print('ProviderType: Email');
                print('Sign-in provider: ${userInfo.providerId}');
                print('Provider-specific UID: ${userInfo.uid}');
                print('Name: ${userInfo.displayName}');
                print('Email: ${userInfo.email}');
                print('Photo URL: ${userInfo.photoURL}');
                emailUser = true;
                break;
            }
          }
        }
      } else {
        print('providerData == null result: Anonymous');
        anonymousUser = true;
      }
    } on Exception catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future<String?> getEmail() async {
    if (await _auth.currentUser?.providerData.length != 0) {
      if (_auth.currentUser?.providerData != null) {
        for (final userInfo in await _auth.currentUser!.providerData) {
          switch (userInfo.providerId) {
            case 'google.com':
              return userInfo.email;
          }
        }
      } else {
        return 'loading';
      }
    }
  }

  String? get currentUserId => _auth.currentUser?.uid;

  // Future<void> reloadUserData() async {
  //   await _auth.currentUser?.reload();
  //   await Future.delayed(const Duration(seconds: 5));
  //   print('ReloadUser');
  //   LoadEnd();
  // }

  Future<bool> get isSignIn async {
    //final currentUser = _firebaseAuth.currentUser;
    final userStream = await _auth.authStateChanges().first;
    return userStream != null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      // await GoogleSignIn().signOut();
    } on FirebaseAuthException catch (e) {
      firebaseErrorSelector(e);
    } on Exception catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteUser(BuildContext context) async {
    final _uid = _auth.currentUser?.uid;
    try {
      EasyLoading.show(status: kEasyLoadingValue);
      final _userDoc = await _firestore.collection('users').doc(_uid).get();
      if (!_userDoc.exists) {
        // Firestore にユーザー用のドキュメントが作られていなければ作る
        await _firestore.collection('users').doc(_uid).set({
          'bug': 'つくられてない',
          'bugAt': Timestamp.now(),
        });
      }
      await _firestore.collection('users').doc(_uid).update({
        'delete': true,
        'deleteAt': Timestamp.now(),
      });
      await _auth.currentUser?.delete();
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      firebaseErrorSelector(e);
      EasyLoading.dismiss();
    } on Exception catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

// Anonymous
  Future<void> anonymousSignup(BuildContext context) async {
    try {
      final userCredential = await _auth.signInAnonymously();
      print(userCredential.user?.uid);
      _firestore.collection('users').doc(userCredential.user?.uid).set({
        'uid': _auth.currentUser!.uid,
        'provider': 'anonymous',
        'createdAt': Timestamp.now(),
      });
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      firebaseErrorSelector(e);
      ProgressHUD.of(context)!.dismiss();
    } on Exception catch (e) {
      print(e);
    }
  }
}

  // void LoadStart() {
  //   // loading = true;
  //   // EasyLoading.showInfo(kEasyLoadingValue,);
  //   notifyListeners();
  // }

  // void LoadEnd() {
  //   // loading = false;
  //   // EasyLoading.dismiss();
  //   notifyListeners();
  // }
  //google

  // Future<void> signUpWithGoogle() async {
  //   try {
  //     //認証をトリガ
  //     LoadStart();
  //     final googleUser = await GoogleSignIn().signIn();
  //     //リクエストから認証の詳細を取得します
  //     final googleAuth = await googleUser?.authentication;
  //     //新しいクレデンシャルを作成します
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //     //サインインしたら、UserCredentialを返します
  //     await _auth.signInWithCredential(credential);
  //     final _uid = await _auth.currentUser?.uid;

  //     final userDoc = await _firestore.collection('users').doc(_uid).get();
  //     if (!userDoc.exists) {
  //       // Firestore にユーザー用のドキュメントが作られていなければ作る
  //       await _firestore.collection('users').doc(_uid).set({
  //         'uid': _uid,
  //         'provider': 'google',
  //         'createdAt': Timestamp.now(),
  //       });
  //     }
  //     showInfo(notificationValue: 'ログインしました');
  //   } on FirebaseAuthException catch (e) {
  //     firebaseErrorSelector(e);
  //   } on Exception catch (e) {
  //     print(e);
  //   } finally {
  //     LoadEnd();
  //   }
  // }

  // Future<void> linkWithGoogle() async {
  //   try {
  //     //認証をトリガ
  //     LoadStart();
  //     final googleUser = await GoogleSignIn().signIn();
  //     //リクエストから認証の詳細を取得します
  //     final googleAuth = await googleUser?.authentication;
  //     //新しいクレデンシャルを作成します
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //     //サインインしたら、UserCredentialを返します
  //     await _auth.currentUser?.linkWithCredential(credential);
  //     showInfo(notificationValue: 'ログインしました');
  //   } on FirebaseAuthException catch (e) {
  //     firebaseErrorSelector(e);
  //   } on Exception catch (e) {
  //     print(e);
  //   } finally {
  //     LoadEnd();
  //   }
  // }

  // Future<void> disconnectGoogle() async {
  //   await getProviderInfo();
  //   if (googleUser == true) {
  //     try {
  //       LoadStart();
  //       await _auth.currentUser?.unlink('google.com');
  //       print(_auth.currentUser);
  //       showInfo(notificationValue: '連携を解除しました');
  //     } on FirebaseAuthException catch (e) {
  //       firebaseErrorSelector(e);
  //     } on Exception catch (e) {
  //       print(e);
  //     } finally {
  //       LoadEnd();
  //     }
  //   }
  // }


  // Future<void> deleteUser() async {
  //   final _uid = _auth.currentUser?.uid;
  //   try {
  //     LoadStart();
  //     await getProviderInfo();
  //     // await _firestore.collection('users').doc(_uid).delete();
  //     await _firestore.collection('users').doc(_uid).update({
  //       'delete': true,
  //       'deleteAt': Timestamp.now(),
  //     });
  //     if (googleUser == true) {
  //       await _auth.currentUser?.unlink('google.com');
  //     }
  //     //全部unlinkすると認証方法がないのに再認証を求められて削除できなくなるので
  //     await _auth.signOut();
  //     await GoogleSignIn().signOut();
  //   } on FirebaseAuthException catch (e) {
  //     firebaseErrorSelector(e);
  //   } on Exception catch (e) {
  //     print(e);
  //   } finally {
  //     LoadEnd();
  //   }
  // }

  // Future<void> deleteGoogle() async {
  //   final _uid = _auth.currentUser?.uid;
  //   if (googleUser == true) {
  //     try {
  //       LoadStart();
  //       await _auth.currentUser?.unlink('google.com');
  //       await _auth.signOut();
  //       await GoogleSignIn().signOut();
  //       final collection = await _firestore.collection('users');
  //       await collection.doc(_uid).delete();
  //       // showInfo(notificationValue: 's');
  //     } on FirebaseAuthException catch (e) {
  //       firebaseErrorSelector(e);
  //     } on Exception catch (e) {
  //       print(e);
  //     } finally {
  //       LoadEnd();
  //     }
  //   }
  // }

  // Future<void> signInWithGoogle() async {
  //   try {
  //     //認証をトリガ
  //     LoadStart();
  //     final googleUser = await GoogleSignIn().signIn();
  //     //リクエストから認証の詳細を取得します
  //     final googleAuth = await googleUser?.authentication;
  //     //新しいクレデンシャルを作成します
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //     //サインインしたら、UserCredentialを返します
  //     await _auth.signInWithCredential(credential);
  //     showInfo(notificationValue: 'ログインしました');
  //   } on FirebaseAuthException catch (e) {
  //     firebaseErrorSelector(e);
  //   } on Exception catch (e) {
  //     print(e);
  //   } finally {
  //     LoadEnd();
  //   }
  // }



  // Future<void> deleteGoogle() async {
  //   try {
  //     LoadStart();
  //     final googleUser = await GoogleSignIn().signIn();
  //     //リクエストから認証の詳細を取得します
  //     final googleAuth = await googleUser?.authentication;
  //     print(googleAuth);
  //     //新しいクレデンシャルを作成します
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //     print(credential);
  //     //サインインしたら、UserCredentialを返します
  //     await _auth.currentUser?.reauthenticateWithCredential(credential);
  //   } on FirebaseAuthException catch (e) {
  //     firebaseErrorSelector(e);
  //   } on Exception catch (e) {
  //     print(e);
  //   } finally {
  //     LoadEnd();
  //   }
  // }
// ログインProviderを全削除後にアカウント削除等の認証が必要な操作をすると、
// 匿名なのにrequires-recent-loginがスローされる
//https://github.com/firebase/firebase-js-sdk/issues/1216
// 匿名でサインインしたユーザーのみが匿名と見なされます。匿名ユーザーが永続的な資格にアップグレードされると、匿名ユーザーは匿名ではなくなります。


//static const String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{7,}$';

// Future<void> getProviderInfo() async {
//   if (await FirebaseAuth.instance.currentUser?.providerData != null) {
//     FirebaseAuth.instance.currentUser!.providerData.forEach((UserInfo) {
//       print('Sign-in provider: ${UserInfo.providerId}');
//       print('  Provider-specific UID: ${UserInfo.uid}');
//       print('  Name: ${UserInfo.displayName}');
//       print('  Email: ${UserInfo.email}');
//       print('  Photo URL: ${UserInfo.photoURL}');
//       switch (UserInfo.providerId) {
//         case 'google.com':
//           ButtonController()
//               .providerTypeSelect(providerType: ProviderType.Google);
//           print('ProviderType Google');
//           break;
//         case 'password':
//           print('ProviderType Email');
//           ButtonController()
//               .providerTypeSelect(providerType: ProviderType.Email);
//           break;
//         default:
//           print('Unknown provider');
//           ;
//       }
//     });
//   } else {
//     print('Unknown provider');
//     ButtonController()
//         .providerTypeSelect(providerType: ProviderType.Anonymous);
//   }
// }
// String get currentUserEmail => _auth.currentUser!.email!;

// List<UserInfo>? get providerList =>
//     FirebaseAuth.instance.currentUser?.providerData;
// String? get providerId => _auth.currentUser?.providerData[0].providerId;
// Future<void> getProviderId() async {
//   if (_auth.currentUser?.providerData[0] != null) {
//     _auth.currentUser!.providerData[0].providerId;
//   } else {
//     print('error');
//   }
// }
  //email and password

  // メールアドレス＆パスワード認証はemailVerified: false,
  // だとGoogleを追加した際に無効になるのでオミット

  // Future<void> pushEmail() async {
  //   try {
  //     if (await isSignIn) {
  //       EasyLoading.show(status: kEasyLoadingValue);
  //       print(User);
  //       await _auth.currentUser?.sendEmailVerification();
  //       showInfo(notificationValue: 'メールを送信しました。');
  //       notifyListeners();
  //     } else {
  //       showInfo(notificationValue: 'メールを送信出来ませんでした。もう一度お試しください');
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //     firebaseErrorSelector(e);
  //   } on Exception catch (e) {
  //     EasyLoading.dismiss();
  //     print(e);
  //     notifyListeners();
  //   }
  // }

  // // Future<void> emailPasswordSignup({
  // //   required String email,
  // //   required String password,
  // // }) async {
  // //   try {
  // //     EasyLoading.show(status: kEasyLoadingValue);
  // //     await _auth.createUserWithEmailAndPassword(
  // //         email: email, password: password);
  // //     print(_auth.currentUser);
  // //     if (await isSignIn) {
  // //       await _auth.currentUser?.sendEmailVerification();
  // //     }
  // //   } on FirebaseAuthException catch (e) {
  // //     print(e);
  // //     firebaseErrorSelector(e);
  // //   } on Exception catch (e) {
  // //     EasyLoading.dismiss();
  // //     print(e);
  // //     notifyListeners();
  // //   }
  // // }

  // Future<void> emailPasswordSignin(
  //     {required String email, required String password}) async {
  //   try {
  //     EasyLoading.show(status: 'loading...');
  //     await _auth.signInWithEmailAndPassword
  //(email: email, password: password);
  //     EasyLoading.dismiss();
  //   } on FirebaseAuthException catch (e) {
  //     firebaseErrorSelector(e);
  //   } on Exception catch (e) {
  //     EasyLoading.dismiss();
  //     print(e);
  //   }
  // }

  // Future<void> sendPasswordReset({
  //   required String email,
  // }) async {
  //   try {
  //     EasyLoading.show(status: 'loading...');
  //     await _auth.sendPasswordResetEmail(email: email);
  //     showInfo(notificationValue: 'メールを送信しました');
  //   } on FirebaseAuthException catch (e) {
  //     firebaseErrorSelector(e);
  //     print(e);
  //   } on Exception catch (e) {
  //     EasyLoading.dismiss();
  //     print(e);
  //   }
  // }

  // Future<void> updateEmail(
  //     {required String email, required String password}) async {
  //   try {
  //     EasyLoading.show(status: 'loading...');
  //     await _auth.signInWithEmailAndPassword(
  //         email: _auth.currentUser!.email.toString(), password: password);
  //     await _auth.currentUser?.updateEmail(email);
  //     await _auth.currentUser?.sendEmailVerification();
  //     showInfo(notificationValue: '変更しました');
  //   } on FirebaseAuthException catch (e) {
  //     firebaseErrorSelector(e);
  //     print(e);
  //     print(_auth.currentUser);
  //   } on Exception catch (e) {
  //     EasyLoading.dismiss();
  //     print(e);
  //   }
  // }

  // Future<void> linkWithEmailPassword(
  //     {required String email, required String password}) async {
  //   try {
  //     EasyLoading.show(status: kEasyLoadingValue);
  //     final credential =
  //         EmailAuthProvider.credential(email: email, password: password);
  //     print(credential);
  //     await _auth.currentUser?.linkWithCredential(credential);

  //     if (emailUser) {
  //       print('Linking accounts succeeded');
  //     } else {
  //       print('Linking accounts faild');
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     firebaseErrorSelector(e);
  //   } on Exception catch (e) {
  //     EasyLoading.dismiss();
  //     print(e);
  //   }
  //   EasyLoading.dismiss();
  // }

  // void linkWithEmail() {

  //   EmailAuthProvider.credential(email: email, password: password)
  // }