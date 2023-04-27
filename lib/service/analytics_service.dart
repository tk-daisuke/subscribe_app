import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

enum AnalyticsEvent {
  Button,
}

/// アナリティクス
class AnalyticsService {
  static final FirebaseAnalytics analytics = FirebaseAnalytics();
  static final FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  /// ボタンタップイベント送信
  Future<void> sendButtonEvent({required String buttonName}) async {
    sendEvent(
        event: AnalyticsEvent.Button,
        parameterMap: {'buttonName': '$buttonName'});
  }

  /// イベントを送信する
  /// [event] AnalyticsEvent
  /// [parameterMap] パラメータMap
  Future<void> sendEvent(
      { required AnalyticsEvent event,
      required Map<String, dynamic> parameterMap}) async {
    final eventName = event.toString().split('.')[1];
    analytics.logEvent(name: eventName, parameters: parameterMap);
  }
}
