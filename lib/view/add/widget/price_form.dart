import 'package:bom_app/constants.dart';
import 'package:bom_app/view/add/add_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PriceForm extends StatelessWidget {
  const PriceForm({
    Key? key,
    required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          // fit: FlexFit.tight,
          child: Consumer<AddModel>(builder: (context, addModel, child) {
            return TextFormField(
              onChanged: (value) {
                if (value.isEmpty) {
                } else {
                  addModel.priceValue = double.parse(value);
                }
              },
              textInputAction: TextInputAction.done,
              // textAlign: TextAlign.right,
              keyboardType: const TextInputType.numberWithOptions(),
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
                // const TitleIcon(icon: Icons.price_change_outlined),
                labelText: ' 円',
                hintText: '数字のみ',
                // fillColor: Colors.black.withOpacity(0.00),
                // filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 2,
                ),
              ),
              validator: (value) => AddModel().TextFormValidator(value: value),
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


        // const AutoSizeText(
        //   'お支払い: ',
        //   style: TextStyle(fontWeight: FontWeight.bold),
        // ),
        // Consumer<AddModel>(builder: (context, addModel, child) {
        //   return DropdownButton<String>(
        //     value: addModel.selectedItem,
        //     iconSize: 24,
        //     style: const TextStyle(color: kTextColor),
        //     // underline: Container(
        //     //   height: 1,
        //     //   color: Colors.cyan,
        //     // ),
        //     onChanged: (String? newValue) {
        //       addModel.updatePlan(newValue!);
        //     },

        //     items: addModel.plans.map((String item) {
        //       return DropdownMenuItem<String>(
        //         child: Text(item),
        //         value: item,
        //       );
        //     }).toList(),
        //   );
        // }),