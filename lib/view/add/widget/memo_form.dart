import 'package:bom_app/constants.dart';
import 'package:bom_app/view/add/add_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MemoForm extends StatelessWidget {
  const MemoForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // TitleIcon(
        //   icon: Icons.text_snippet,
        // ),
        Flexible(
          child: Consumer<AddModel>(builder: (context, addModel, child) {
            return TextFormField(
              onChanged: (value) {
                addModel.memoValue = value;
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
