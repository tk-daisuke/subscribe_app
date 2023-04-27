import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
import 'package:flutter/material.dart';

class AuthLinkButton extends StatelessWidget {
  const AuthLinkButton({
    required this.onPressed,
    required this.title,
    required this.enable,
  });
  final VoidCallback onPressed;
  final String title;
  final bool enable;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: enable
          ? onPressed
          : () {
              print('ボタン無効');
            },
      label: AutoSizeText(
        title,
        textScaleFactor: kTextScaleFactor,
        maxFontSize: 18,
        maxLines: 1,
        style: const TextStyle(fontSize: 18, color: kTextColor),
      ),
      icon: const Icon(
        Icons.login_rounded,
        color: kTextColor,
      ),
      style: ElevatedButton.styleFrom(
          primary: kButtonText,
          side: const BorderSide(
            width: 1,
          )),
    );
  }
}
