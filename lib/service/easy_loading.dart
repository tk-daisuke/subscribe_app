import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EasyLoadingService extends ChangeNotifier {
  void showInfo({required String notificationValue}) {
    EasyLoading.showInfo('$notificationValue');
    notifyListeners();
  }
}
