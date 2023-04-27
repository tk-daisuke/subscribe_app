import 'package:bom_app/constants.dart';
import 'package:bom_app/item/subscription_item.dart';
import 'package:bom_app/service/auth_service.dart';
import 'package:bom_app/service/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditModel extends ChangeNotifier {
  // int unitValue = 0;
  final units = <String>['日', '週', '月', '年'];
  final unitValues = List.generate(31, (index) => '${index + 1}');
  // final daysItems = List.generate(31, (index) => '${index + 1}');
  // final monthItems = List.generate(12, (index) => '${index + 1}');
  // final yearsItems = List.generate(10, (index) => '$index');

  String nameValue = '';
  double priceValue = 0;
  DateTime reloadTime = DateTime.now();
  String selectDay = '1';
  String selectUnit = '月';
  int selectUnitNumber = 2;
  String memoValue = '';
  bool isViewEnable = true;

  final isEnable = true;
  final updateRequired = '1.0.0';
  void hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
// Formの変数

  void updateTime(DateTime date) {
    reloadTime = date;
    notifyListeners();
  }

  void daysOnSelect({required int index}) {
    selectDay = unitValues[index];
    notifyListeners();
  }

  void unitOnSelect({required int index}) {
    selectUnit = units[index];
    selectUnitNumber = index;
    notifyListeners();
  }

  void toggleButton({required bool isAvtive}) {
    isViewEnable = isAvtive;
    notifyListeners();
  }

  // Validation
  String? TextFormValidator({required String? value}) {
    if (value!.isEmpty) {
      return '必須';
    }
    //null以外を返すと、フィールドの値が無効であることを示します。
    return null;
  }

  Future<void> EditFormSubmit(
      BuildContext context,
      GlobalKey<FormState> formKey,
      SubscriptionItem item,
      FirestoreService firestore) async {
    final docData = <String, Object>{
      'name': nameValue,
      'price': priceValue,
      'unit': selectUnit,
      'unitNumber': selectUnitNumber,
      'memo': memoValue,
      'next_reload': int.parse(selectDay),
      'start_time': reloadTime,
      'lastUpdate': firestore.serverTimeStamp,
      'isEnable': isEnable,
      'isViewEnable': isViewEnable,
      'updateRequired': updateRequired,
      'Genre': 'none',
    };
    final _uid = context.read<AuthService>().currentUserId;

    if (formKey.currentState!.validate()) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text('')));

      Navigator.pop(context);
      await firestore.updateSubscribes(
        _uid!,
        docData,
        item,
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('未入力の項目があります')));
    }
  }

  // void itemInvalue({required SubscriptionItem item}) {
  //   selectDay = item.next_reload.toString();
  //   selectUnitNumber = item.unitNumber;
  //   notifyListeners();
  // }

// Dialog
  Future<void> cupertinoPickerDialog(BuildContext context,
      {required Size size, required SubscriptionItem item}) {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
            height: size.height / 3,
            color: kPrimaryColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('更新間隔'),
                    TextButton(
                      child: const Text('閉じる'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('決定'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Consumer<EditModel>(
                            builder: (context, editModel, child) {
                          return CupertinoPicker(
                            looping: true,
                            itemExtent: 30,
                            onSelectedItemChanged: (index) =>
                                daysOnSelect(index: index),
                            scrollController: FixedExtentScrollController(
                                initialItem:
                                    int.parse(editModel.selectDay) - 1),
                            children: unitValues
                                .map((days) => new Text(
                                      days,
                                      textScaleFactor: kTextScaleFactor,
                                    ))
                                .toList(),
                          );
                        }),
                        // .map((String days) {
                        //   return Text(
                        //     days,
                        //   );
                        // }).toList(),
                      ),
                      Expanded(
                        child: Consumer<EditModel>(
                            builder: (context, editModel, child) {
                          final _unit = units
                              .map((unit) => new Text(
                                    unit,
                                    textScaleFactor: kTextScaleFactor,
                                  ))
                              .toList();
                          return CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                                initialItem: selectUnitNumber),
                            itemExtent: 30,
                            onSelectedItemChanged: (index) {
                              unitOnSelect(
                                index: index,
                              );
                              selectUnitNumber = index;
                              print(selectUnitNumber);
                            },
                            children: _unit,
                          );
                        }),
                      ),
                      const Expanded(
                          flex: 1,
                          child: Center(
                              child: Text('毎に',
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 16,
                                    color: Colors.black,
                                  )))),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
