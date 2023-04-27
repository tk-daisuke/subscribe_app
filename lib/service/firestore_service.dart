import 'package:bom_app/constants.dart';
import 'package:bom_app/item/ios_version.dart';
import 'package:bom_app/item/price.dart';
import 'package:bom_app/item/subscription_item.dart';
import 'package:bom_app/service/calculation_system.dart';
import 'package:bom_app/view/list/widget/subscription.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FirestoreService extends ChangeNotifier {
  FirestoreService(this._firestore);
  final FirebaseFirestore _firestore;
  final serverTimeStamp = FieldValue.serverTimestamp();

  //  FieldValue.serverTimestamp()

  void LoadStart() {
    EasyLoading.show(status: kEasyLoadingValue);

    notifyListeners();
  }

  void LoadEnd() {
    EasyLoading.dismiss();
    notifyListeners();
  }

  void showInfo({required String notificationValue}) {
    //ローディングを破棄
    EasyLoading.dismiss();

    //お知らせテキストを表示
    EasyLoading.showInfo('$notificationValue');
    notifyListeners();
  }

  Future<void> addSubscribes(String _uid, Map<String, Object> docData) async {
    try {
      // LoadStart();
      await _firestore
          .collection('users')
          .doc(_uid)
          .collection('subscribes')
          .add(docData)
          .then((value) => print('User Added $value'));
    } on Exception catch (e) {
      print('Failed to add user: $e');
      // LoadEnd();
    }
  }

  Future<IosVersion> appUpdateCheck() async {
    const settingDoc = 'IfUJnUQQZsg6eKaKY1QG';
    try {
      // LoadStart();
      final doc =
          await _firestore.collection('app_settings').doc(settingDoc).get();
      print('doc.data() ${doc.data()}');
      final data = doc.data() ??
          {'ios_release_version': kAppVersion, kAppVersion: kAppVersion};

      return IosVersion(
          requiredVersion: data['ios_release_version'] ?? '1.0.0',
          testVersion: data[kAppVersion] ?? kAppVersion);
    } on Exception catch (e) {
      print('Failed to add user: $e');
    } 
    return IosVersion(requiredVersion: '1.0.0', testVersion: '1.0.0');
  }

  Future<void> updateSubscribes(
      String _uid, Map<String, Object> docData, SubscriptionItem item) async {
    try {
      // LoadStart();
      await _firestore
          .collection('users')
          .doc(_uid)
          .collection('subscribes')
          .doc(item.docID)
          .update(docData);
    } on Exception catch (e) {
      print('Failed to add user: $e');
    }
  }

  SubscriptionItem firestoreConverter(DocumentSnapshot<Object?> doc) {
    return SubscriptionItem(
      name: doc['name'] ?? '',
      price: double.parse(doc['price'].toString()),
      startTime: timestampConvert(doc['start_time'] ?? Timestamp.now()),
      unit: doc['unit'] ?? '日',
      unitNumber: doc['unitNumber'] ?? 0,
      next_reload: doc['next_reload'] ?? 0,
      lastUpdate: timestampConvert(doc['lastUpdate'] ?? Timestamp.now()),
      memo: doc['memo'] ?? '',
      isViewEnable: doc['isViewEnable'] ?? true,
      docID: doc.id,
      isEnable: doc['isEnable'] ?? true,
    );
  }

  Future<QuerySnapshot> getSubscribes(String _uid) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(_uid)
        .collection('subscribes')
        .orderBy('unitNumber')
        .limit(99)
        .get();
    return snapshot;
  }

  Future<QuerySnapshot> getSqueezeSubscribes(String _uid, String unit) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(_uid)
        .collection('subscribes')
        .where(
          'unit',
          isEqualTo: unit,
        )
        .limit(99)
        .get();
    return snapshot;
  }

  List<Widget> snapshotList(List<DocumentSnapshot> documents) {
    final subs = documents.map((doc) {
      return Subscription(
        item: firestoreConverter(doc),
      );
    });
    return subs.toList();
    // items...add(item)..
  }

  List<Price> priceConvert(List<DocumentSnapshot> documents) {
    final _calculation = CalculationSystem();

    final result = documents.map((doc) {
      final item = firestoreConverter(doc);
      final _finalPrice = _calculation.perMoney(
          price: item.price, index: item.unitNumber, par: item.next_reload);
      final _dayPrice = _finalPrice.days;
      final _weekPrice = _finalPrice.weeklys;
      final _monthPrice = _finalPrice.month;
      final _yearPrice = _finalPrice.years;
      final isActive = item.isViewEnable;
      return Price(
        name: item.name,
        day: _dayPrice,
        week: _weekPrice,
        month: _monthPrice,
        year: _yearPrice,
        isActive: isActive,
      );
    }).toList();
    return result;
  }

  DateTime timestampConvert(Timestamp time) {
    return time.toDate();
  }

  double intToDouble(int value) {
    return double.parse(value.toString());
  }

  Future deleteItem(SubscriptionItem item, String? uid) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('subscribes')
          .doc(item.docID)
          .delete();
      showInfo(notificationValue: '削除しました。');
    } on Exception catch (e) {
      print(e);
    }
  }

  void reload() {
    LoadEnd();
  }
}
