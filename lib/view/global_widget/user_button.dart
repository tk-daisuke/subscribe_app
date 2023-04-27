import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
import 'package:flutter/material.dart';

class UserButton extends StatelessWidget {
  const UserButton({
    required this.sized,
    required this.text,
    required this.onPresse,
    this.subTextWidget = const SizedBox(),
    this.icon = const SizedBox(),
  });

  final Size sized;
  final String text;
  final Widget subTextWidget;
  final VoidCallback onPresse;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      child: ElevatedButton(
        onPressed: onPresse ,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: sized.width * 0.04,
            ),
            icon,
            SizedBox(
              width: sized.width * 0.02,
            ),
            Expanded(
              child: AutoSizeText(text,
                  textScaleFactor: kTextScaleFactor,
                  maxFontSize: 20,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 20, color: kTextColor)),
            ),
            subTextWidget,
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
            SizedBox(
              width: sized.width * 0.05,
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          primary: Colors.white,
          elevation: 0,
          // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
