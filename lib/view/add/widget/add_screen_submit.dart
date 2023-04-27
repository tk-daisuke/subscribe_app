import 'package:bom_app/service/analytics_service.dart';
import 'package:bom_app/service/firestore_service.dart';
import 'package:bom_app/view/add/add_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddScreenSubmit extends StatelessWidget {
  const AddScreenSubmit({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    final _analytics = AnalyticsService();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Consumer2<AddModel, FirestoreService>(
          builder: (context, addModel, firestore, child) {
        return ElevatedButton(
          onPressed: () async {
            print(addModel.nameValue);
            _analytics.sendButtonEvent(buttonName: '追加保存ボタン');
            addModel.hideKeyboard(context);
            await addModel.AddFormSubmit(context, _formKey, firestore);
            // context.read<FirestoreService>().reload();
          },

          // () async {
          //   _analytics.sendButtonEvent(buttonName: '追加保存ボタン');
          //   addModel.hideKeyboard(context);
          //   await addModel.AddFormSubmit(context, _formKey, firestore);

          //   // context.read<FirestoreService>().reload();
          // },
          child: const Text('保存する'),
        );
      }),
    );
  }
}
            // final progress = ProgressHUD.of(context);
            // progress!.show();        // await Future.delayed(Duration.zero, progress.dismiss);
        // context: context,
        //       formKey: _formKey,
        //       name: AddModel().nameValue,
        //       price: int.parse(AddModel().priceValue),
        //       unit: AddModel().selectUnit,
        //       unitValue: AddModel().selectUnitNumbar,
        //       next_reload: int.parse(AddModel().selectDay),
        //       start_time: AddModel().reloadTime,
        //       last_update: DateTime.now());