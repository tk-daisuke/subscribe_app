import 'package:bom_app/constants.dart';
import 'package:bom_app/service/auth_service.dart';
import 'package:bom_app/service/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddModel extends ChangeNotifier {
  // int unitValue = 0;
  final units = <String>['日', '週', '月', '年'];
  final unitValues = List<String>.generate(31, (index) => '${index + 1}');
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
  final isViewEnable = true;
  final isEnable = true;
  final updateRequired = '1.0.0';

// Formの変数

  void hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

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

  // Validation
  String? TextFormValidator({required String? value}) {
    if (value!.isEmpty) {
      return '必須';
    }
    //null以外を返すと、フィールドの値が無効であることを示します。
    return null;
  }

  Future<void> AddFormSubmit(BuildContext context, GlobalKey<FormState> formKey,
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
      await firestore.addSubscribes(_uid!, docData);
      // await Future.delayed(Duration.zero, () {

      // });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('未入力の項目があります')));
    }
  }

// Dialog
  Future<void> cupertinoPickerDialog(
    BuildContext context,
  ) {
    final _size = MediaQuery.of(context).size;

    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
            height: _size.height / 3,
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
                        child: Consumer<AddModel>(
                            builder: (context, addModel, child) {
                          return CupertinoPicker(
                            looping: true,
                            itemExtent: 30,
                            scrollController: FixedExtentScrollController(
                                initialItem: int.parse(addModel.selectDay) - 1),
                            onSelectedItemChanged: (index) =>
                                daysOnSelect(index: index),
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
                        child: Consumer<AddModel>(
                            builder: (context, addModel, child) {
                          return CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                                initialItem: selectUnitNumber),
                            itemExtent: 30,
                            onSelectedItemChanged: (index) => unitOnSelect(
                              index: index,
                            ),
                            children: units
                                .map((unit) => new Text(
                                      unit,
                                      textScaleFactor: kTextScaleFactor,
                                    ))
                                .toList(),
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
// void unitPicker(int value) {
//   unitValue = value;
//   if (value == 0) {
//     valueItems = daysItems;
//     print(valueItems);
//     notifyListeners();
//   } else if (value == 1) {
//     valueItems = monthItems;
//     print(valueItems);
//     notifyListeners();
//   } else if (value == 2) {
//     valueItems = yearsItems;
//     print(valueItems);
//     notifyListeners();
//   }

// Expanded(child: Consumer<AddModel>(
//                         builder: (context, addModel, child) {
//                       if (unitValue == 0) {
//                         return CupertinoPicker(
//                             itemExtent: 30,
//                             onSelectedItemChanged: print,
//                             children: []);
//                       } else if (unitValue == 1) {
//                         return CupertinoPicker(
//                             itemExtent: 30,
//                             onSelectedItemChanged: s,
//                             children: monthItems);
//                       } else if (unitValue == 2) {
//                         return CupertinoPicker(
//                             itemExtent: 30,
//                             onSelectedItemChanged: print,
//                             children: yearsItems);
//                       }
//                       ;
//                       return Container();
//                     })),
