import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdHelper extends ChangeNotifier {
  final String kiOSTestBunner = 'ca-app-pub-3940256099942544/2934735716';
  final String kAndroidTextBunner = 'ca-app-pub-3940256099942544/6300978111';
  Future<void> admodCheck() async {
    //トラッキング設定取得
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await Future.delayed(const Duration(milliseconds: 200));
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return kAndroidTextBunner;
    } else if (Platform.isIOS) {
      return kiOSTestBunner;
    }
    throw new UnsupportedError('Unsupported platform');
  }

  String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return kAndroidTextBunner;
    } else if (Platform.isIOS) {
      return kiOSTestBunner;
    }
    throw new UnsupportedError('Unsupported platform');
  }
}
