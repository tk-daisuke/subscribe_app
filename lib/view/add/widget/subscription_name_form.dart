import 'package:bom_app/constants.dart';
import 'package:bom_app/view/add/add_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SubscriptionNameForm extends StatelessWidget {
  const SubscriptionNameForm({
    Key? key,
    required Size size,
  })  : _size = size,
        super(key: key);

  // ignore: unused_field
  final Size _size;
  // final AddModel addModel = AddModel();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // const TitleIcon(icon: Icons.smart_display_outlined),
        Flexible(
          child: Consumer<AddModel>(builder: (context, addModel, child) {
            return TextFormField(
              onChanged: (value) {
                addModel.nameValue = value;
                print(value);
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
                // const TitleIcon(icon: Icons.smart_display_outlined),
                // fillColor: Colors.black.withOpacity(0.03),
                // filled: true,
                labelText: ' サブスク名',
                // hintText: 'サブスク名',
              ),
              validator: (value) => AddModel().TextFormValidator(value: value),
            );
          }),
        ),
        // SizedBox(
        //   width: _size.width / 10,
        // ),
      ],
    );
  }
}
