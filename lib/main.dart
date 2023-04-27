import 'package:bom_app/service/ad_helper.dart';
import 'package:bom_app/service/analytics_service.dart';
import 'package:bom_app/service/easy_loading.dart';
import 'package:bom_app/service/firestore_service.dart';
import 'package:bom_app/view/account_delete/account_delete_model.dart';
import 'package:bom_app/view/account_delete/account_delete_screen.dart';
import 'package:bom_app/view/account_edit/account_edit_model.dart';
import 'package:bom_app/view/account_edit/account_edit_screen.dart';
import 'package:bom_app/view/add/add_model.dart';
import 'package:bom_app/view/add/add_screen.dart';
import 'package:bom_app/view/edlit/edit_model.dart';
import 'package:bom_app/view/list/list_model.dart';
import 'package:bom_app/view/list/list_screen.dart';
import 'package:bom_app/view/root/root_model.dart';
// Project imports:
import 'package:bom_app/view/root/root_screen.dart';
import 'package:bom_app/view/user/user_screen.dart';
import 'package:bom_app/view/welcome/welcome_model.dart';
import 'package:bom_app/view/welcome/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:simple_logger/simple_logger.dart';

import 'service/auth_service.dart';

Future<void> main() async {
  final logger = SimpleLogger();
  // FlutterアプリからFirebaseエミュレーターに接続
// https://medium.com/flutter-jp/firebase-emulator-938e9a0cdfad
  const isEmulator = bool.fromEnvironment('IS_EMULATOR');
  logger.fine('start(isEmulator: $isEmulator)');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (isEmulator) {
    print('isEmulator$isEmulator');
    const localhost = 'localhost';

    FirebaseFirestore.instance.useFirestoreEmulator(localhost, 8080);
    await Future.wait(
      [FirebaseAuth.instance.useAuthEmulator(localhost, 9099)],
    );
  }

  await MobileAds.instance.initialize();
  if (kDebugMode) {
    await FirebaseAuth.instance
        .userChanges()
        .listen((final User? _firebaseUser) {
      if (_firebaseUser != null) {
        print(_firebaseUser);
        print('User sign in');
      } else {
        print(_firebaseUser);
        print('User sign out');
      }
    });
  } else {
    final _user = await FirebaseAuth.instance.userChanges();

    print('MAIN${_user.first}');
  }
  runApp(Bom());
}

class Bom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RootModel>(create: (context) => RootModel()),
        ChangeNotifierProvider<AuthService>(
            create: (context) => AuthService(FirebaseAuth.instance)),
        ChangeNotifierProvider<ListModel>(create: (context) => ListModel()),
        ChangeNotifierProvider<AddModel>(create: (context) => AddModel()),
        ChangeNotifierProvider<EditModel>(create: (context) => EditModel()),
        ChangeNotifierProvider<WelcomeModel>(
            create: (context) => WelcomeModel()),
        ChangeNotifierProvider<AccountEditModel>(
            create: (context) => AccountEditModel()),
        ChangeNotifierProvider<FirestoreService>(
            create: (context) => FirestoreService(FirebaseFirestore.instance)),
        ChangeNotifierProvider<EasyLoadingService>(
            create: (context) => EasyLoadingService()),
        ChangeNotifierProvider<AdHelper>(create: (context) => AdHelper()),
        ChangeNotifierProvider<AccountDeleteModel>(
            create: (context) => AccountDeleteModel()),
        StreamProvider<User?>(
            initialData: null,
            create: (context) {
              return FirebaseAuth.instance.userChanges();
            }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // scaffoldBackgroundColor: kBackgroundColor,
            // fontFamily: 'NotoSansJp',
            ),
        navigatorObservers: [
          AnalyticsService.observer,
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ja'),
        ],
        locale: const Locale('ja', 'JP'),
        initialRoute: RootScreen.id,
        routes: {
          RootScreen.id: (context) => RootScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          // HomeScreen.id: (context) => HomeScreen(),
          ListScreen.id: (context) => ListScreen(),
          AddScreen.id: (context) => AddScreen(),
          UserScreen.id: (context) => UserScreen(),
          AccountEditScreen.id: (context) => AccountEditScreen(),
          AccountDeleteScreen.id: (context) => const AccountDeleteScreen(),
        },
        builder: EasyLoading.init(),
      ),
    );
  }
}
