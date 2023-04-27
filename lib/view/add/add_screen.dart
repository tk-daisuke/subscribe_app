import 'package:bom_app/constants.dart';
import 'package:bom_app/service/analytics_service.dart';
import 'package:bom_app/view/add/widget/add_screen_submit.dart';
import 'package:bom_app/view/add/widget/close_dialog.dart';
import 'package:bom_app/view/add/widget/memo_form.dart';
import 'package:bom_app/view/add/widget/price_form.dart';
import 'package:bom_app/view/add/widget/reload_picker.dart';
import 'package:bom_app/view/add/widget/reload_time_selector.dart';
import 'package:bom_app/view/add/widget/subscription_name_form.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class AddScreen extends StatelessWidget {
  static const String id = 'add_screen';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _keyBoradSize = MediaQuery.of(context).viewInsets.bottom;
    // context.read<AddModel>().reset();
    //   selectDay = '1';
    //   selectUnit = '月';
    //   selectUnitNumber = 2;
    final _analytics = AnalyticsService();
    return ProgressHUD(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Icon(
            Icons.edit,
            size: 50,
          ),
          elevation: 0,
          backgroundColor: kPrimaryColor,
          leading: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            elevation: 0,
            child: const Icon(
              Icons.clear_outlined,
              color: kTextColor,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _analytics.sendButtonEvent(buttonName: '追加やめるダイアログ');
                CloseDialog(context);
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  bottom: _keyBoradSize,
                ),
                child: Form(
                  key: _formKey,
                  child: Container(
                    color: kPrimaryColor,
                    margin:
                        EdgeInsets.symmetric(horizontal: _size.width * 0.01),
                    child: Column(
                      children: <Widget>[
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            //入力必須
                            SubscriptionNameForm(size: _size),
                            const Divider(),
                            PriceForm(size: _size),
                            const Divider(),
                            ReloadTimeSelector(),
                            const Divider(),
                            ReloadPicker(),
                            // const NextReload(),
                            const Divider(),
                            //入力必須ではない
                            const MemoForm(),
                          ],
                        ),
                        AddScreenSubmit(formKey: _formKey),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



  // [
  //                                   if (addModel.unitValue == 0)
  //                                     for (int day = 0;
  //                                         day < addModel.daysItems;
  //                                         day++)
  //                                       new Text(
  //                                         '${day + 1}',
  //                                         style: const TextStyle(
  //                                             color: Colors.black87,
  //                                             fontSize: 16,
  //                                             fontWeight: FontWeight.bold),
  //                                       )
  //                                   else if (addModel.unitValue == 1)
  //                                     for (int month = 0;
  //                                         month < addModel.monthItems;
  //                                         month++)
  //                                       new Text(
  //                                         '${month + 1}',
  //                                         style: const TextStyle(
  //                                             color: Colors.black87,
  //                                             fontSize: 16,
  //                                             fontWeight: FontWeight.bold),
  //                                       )
  //                                   else if (addModel.unitValue == 2)
  //                                     for (int year = 0;
  //                                         year < addModel.yearsItems;
  //                                         year++)
  //                                       new Text(
  //                                         '${year + 1}',
  //                                         style: const TextStyle(
  //                                             color: Colors.black87,
  //                                             fontSize: 16,
  //                                             fontWeight: FontWeight.bold),
  //                                       ),
  //                                 ]
  //                                 // _values.map((String items) {
  //                                 //   return Text(
  //                                 //     items,
  //                                 //     style: const TextStyle(
  //                                 //         color: Colors.black87,
  //                                 //         fontSize: 16,
  //                                 //         fontWeight: FontWeight.bold),
  //                                 //   );
  //                                 // }).toList()
  