import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
import 'package:bom_app/item/subscription_item.dart';
import 'package:bom_app/service/analytics_service.dart';
import 'package:bom_app/service/firestore_service.dart';
import 'package:bom_app/view/add/widget/close_dialog.dart';
import 'package:bom_app/view/add/widget/title_icon.dart';
import 'package:bom_app/view/edlit/edit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatelessWidget {
  EditScreen({required this.item});
  static const String id = 'edit_screen';

  final _formKey = GlobalKey<FormState>();
  final SubscriptionItem item;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _keyBoradSize = MediaQuery.of(context).viewInsets.bottom;
    final _analytics = AnalyticsService();
    return ProgressHUD(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            '編集中',
            style: const TextStyle(color: kTextColor),
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
              _analytics.sendButtonEvent(buttonName: '編集閉じるダイアログ');
              CloseDialog(context);
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: _size.height * 0.01, horizontal: 8),
                          child: Column(
                            children: <Widget>[
                              _nameForm(item: item),
                              const Divider(),
                              _priceForm(item: item, size: _size),
                              const Divider(),
                              _startTimeForm(item: item),
                              const Divider(),
                              _reloadTimeForm(size: _size, item: item),
                              // const NextReload(),
                              const Divider(),
                              _toggleButton(item: item),

                              const Divider(),
                              //入力必須ではない
                              _memoForm(item: item),
                            ],
                          ),
                        ),
                        //へんこう
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 5),
                          child: Consumer2<EditModel, FirestoreService>(
                              builder: (context, editModel, firestore, child) {
                            return ElevatedButton(
                              onPressed: () async {
                                _analytics.sendButtonEvent(buttonName: '編集完了');
                                editModel.hideKeyboard(context);
                                await editModel.EditFormSubmit(
                                    context, _formKey, item, firestore);
                                context.read<FirestoreService>().reload();
                              },
                              child: const Text('保存する'),
                            );
                          }),
                        ),
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

class _toggleButton extends StatelessWidget {
  const _toggleButton({
    Key? key,
    required this.item,
  }) : super(key: key);

  final SubscriptionItem item;

  @override
  Widget build(BuildContext context) {
    final _analytics = AnalyticsService();

    return Column(
      children: [
        Row(
          children: [
            const TitleIcon(
              icon: Icons.calculate_outlined,
            ),
            const Flexible(
              child: const AutoSizeText(
                '合計計算に含める',
                textScaleFactor: kTextScaleFactor,
                style: TextStyle(
                  fontSize: 18,
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Consumer<EditModel>(builder: (context, editModel, child) {
              return Checkbox(
                // checkColor: Colors.white,
                // fillColor: kPrimaryColor,
                // MaterialStateProperty.resolveWith(
                //     ),
                value: editModel.isViewEnable,
                onChanged: (toggle) {
                  editModel.hideKeyboard(context);
                  _analytics.sendButtonEvent(buttonName: '合計料金に含めるかtoggle');
                  editModel.toggleButton(
                      isAvtive: toggle ?? editModel.isViewEnable);
                },
              );
            }),

            // toggleButton
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.access_alarm,
              color: kPrimaryColor,
              size: 36,
            ),
            const Icon(
              Icons.arrow_right,
              color: Colors.amber,
              size: 36,
            ),
            const Text(
              '現在:',
              textScaleFactor: kTextScaleFactor,
              style: const TextStyle(
                fontSize: 19,
                color: kTextColor,
              ),
            ),
            if (item.isViewEnable)
              const AutoSizeText(
                '含める',
                textScaleFactor: kTextScaleFactor,
                style: const TextStyle(
                  fontSize: 19,
                  color: kTextColor,
                ),
              )
            else
              const AutoSizeText(
                '含めない',
                textScaleFactor: kTextScaleFactor,
                style: const TextStyle(
                  fontSize: 19,
                  color: kTextColor,
                ),
              )
          ],
        ),
      ],
    );
  }
}

class _memoForm extends StatelessWidget {
  const _memoForm({
    Key? key,
    required this.item,
  }) : super(key: key);

  final SubscriptionItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Consumer<EditModel>(builder: (context, editModel, child) {
            return TextFormField(
              initialValue: editModel.memoValue,
              onChanged: (value) {
                editModel.memoValue = value;
              },
              textInputAction: TextInputAction.done,
              // textAlign: TextAlign.right,
              keyboardType: TextInputType.text,
              maxLines: 2,
              cursorColor: kTextColor,
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
              ],

              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.text_snippet,
                  size: 36,
                  color: kTextColor,
                ),
                labelText: ' メモ',
                hintText: '最大20文字',
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 2,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _reloadTimeForm extends StatelessWidget {
  const _reloadTimeForm({
    Key? key,
    required Size size,
    required this.item,
  })  : _size = size,
        super(key: key);

  final Size _size;
  final SubscriptionItem item;

  @override
  Widget build(BuildContext context) {
    return Consumer<EditModel>(builder: (context, editModel, child) {
      final _analytics = AnalyticsService();

      return Column(
        children: [
          Row(
            children: [
              const TitleIcon(
                icon: Icons.autorenew,
              ),
              Flexible(
                child: TextButton(
                  onPressed: () async {
                    editModel.hideKeyboard(context);
                    _analytics.sendButtonEvent(buttonName: '編集 更新頻度');
                    editModel.cupertinoPickerDialog(context,
                        size: _size, item: item);
                  },
                  style: TextButton.styleFrom(),
                  child: Row(
                    children: [
                      if (editModel.selectUnit != '月')
                        Flexible(
                          child: AutoSizeText(
                            '${editModel.selectDay}${editModel.selectUnit}毎に更新',
                            textScaleFactor: kTextScaleFactor,
                            style: const TextStyle(
                              fontSize: 20,
                              color: kTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      else
                        Flexible(
                          child: Text(
                            // ignore: lines_longer_than_80_chars
                            '${editModel.selectDay}ヶ${editModel.selectUnit}毎に更新',
                            textScaleFactor: kTextScaleFactor,
                            style: const TextStyle(
                              fontSize: 20,
                              color: kTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      const Icon(
                        Icons.expand_more_outlined,
                        size: 32,
                        // color: Colors.pinkAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.access_alarm,
                color: kPrimaryColor,
                size: 36,
              ),
              const Icon(
                Icons.arrow_right,
                color: Colors.amber,
                size: 36,
              ),
              if (item.unit != '月')
                Flexible(
                  child: AutoSizeText(
                    '現在の登録:${item.next_reload}${item.unit}毎に更新',
                    textScaleFactor: kTextScaleFactor,
                    style: const TextStyle(
                      fontSize: 19,
                      color: kTextColor,
                    ),
                  ),
                )
              else
                Flexible(
                  child: AutoSizeText(
                    '現在の登録:${item.next_reload}ヶ${item.unit}毎に更新',
                    textScaleFactor: kTextScaleFactor,
                    style: const TextStyle(
                      fontSize: 19,
                      color: kTextColor,
                    ),
                  ),
                ),
            ],
          ),
        ],
      );
    });
  }
}

class _startTimeForm extends StatelessWidget {
  const _startTimeForm({
    Key? key,
    required this.item,
  }) : super(key: key);

  final SubscriptionItem item;

  @override
  Widget build(BuildContext context) {
    final _analytics = AnalyticsService();

    return Column(
      children: [
        Row(
          children: <Widget>[
            const TitleIcon(
              icon: Icons.schedule_sharp,
            ),
            Consumer<EditModel>(builder: (context, editModel, child) {
              return Flexible(
                child: TextButton(
                  style: TextButton.styleFrom(),
                  onPressed: () async {
                    editModel.hideKeyboard(context);
                    _analytics.sendButtonEvent(buttonName: '編集 スタートタイム');

                    final picked = await showDatePicker(
                      locale: const Locale('ja'),
                      context: context,
                      initialDate: editModel.reloadTime,
                      firstDate: DateTime(2000, 1, 1),
                      lastDate: DateTime.now().add(const Duration(days: 60)),
                    );
                    if (picked != null) {
                      // 日時反映
                      editModel.updateTime(picked);
                    }
                  },
                  child: Row(
                    children: [
                      Flexible(
                        child: AutoSizeText(
                          // ignore: lines_longer_than_80_chars
                          '登録日 :${DateFormat('yyyy年M月d日').format(editModel.reloadTime)}',
                          textScaleFactor: kTextScaleFactor,

                          maxFontSize: 20,
                          maxLines: 1,
                          style: const TextStyle(
                            color: kTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.expand_more_outlined,
                        size: 32,
                        // color: Colors.pinkAccent,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.arrow_right,
              color: kPrimaryColor,
              size: 36,
            ),
            const Icon(
              Icons.arrow_right,
              color: Colors.amber,
              size: 36,
            ),
            Flexible(
              child: AutoSizeText(
                '現在の登録日 :'
                '${DateFormat('yyyy年M月d日').format(item.startTime)}',
                textScaleFactor: kTextScaleFactor,
                maxFontSize: 19,
                maxLines: 2,
                style: const TextStyle(
                  color: kTextColor,
                  fontSize: 19,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _priceForm extends StatelessWidget {
  const _priceForm({
    Key? key,
    required this.item,
    required Size size,
  })  : _size = size,
        super(key: key);

  final SubscriptionItem item;
  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          // fit: FlexFit.tight,
          child: Consumer<EditModel>(builder: (context, editModel, child) {
            return TextFormField(
              initialValue: editModel.priceValue.toStringAsFixed(0),
              onChanged: (value) {
                if (value.isEmpty) {
                } else {
                  editModel.priceValue = double.parse(value);
                }
              },
              textInputAction: TextInputAction.done,
              // textAlign: TextAlign.right,
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
              ),

              cursorColor: kTextColor,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^[0-9]{0,7}')),
              ],
              decoration: const InputDecoration(
                icon: const Icon(
                  Icons.price_change_outlined,
                  size: 36,
                  color: kTextColor,
                ),
                labelText: ' 円',
                hintText: '数字のみ',
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 2,
                ),
              ),
              validator: (value) =>
                  context.read<EditModel>().TextFormValidator(value: value),
            );
          }),
        ),
        SizedBox(
          width: _size.width / 10,
        ),
      ],
    );
  }
}

class _nameForm extends StatelessWidget {
  const _nameForm({
    Key? key,
    required this.item,
  }) : super(key: key);

  final SubscriptionItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Consumer<EditModel>(builder: (context, editModel, child) {
            return TextFormField(
                initialValue: editModel.nameValue,
                onChanged: (value) {
                  editModel.nameValue = value;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                // textAlign: TextAlign.right,
                cursorColor: kTextColor,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(20),
                ],
                decoration: const InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 2,
                  ),
                  icon: const Icon(
                    Icons.smart_display_outlined,
                    size: 36,
                    color: kTextColor,
                  ),
                  labelText: ' サブスク名',
                ),
                validator: (value) {
                  context.read<EditModel>().TextFormValidator(value: value);
                });
          }),
        ),
      ],
    );
  }
}
