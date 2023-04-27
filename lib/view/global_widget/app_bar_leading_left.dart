// Flutter imports:

import 'package:bom_app/constants.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:

class AppBarLeadingLeft extends StatelessWidget {
  const AppBarLeadingLeft(
      {required this.icon,
      required this.text,
      required this.color,
      required this.onPressed});
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Icon(
              icon,
              color: color,
            ),
          ),
          Expanded(
            flex: 2,
            child: AutoSizeText(
              text,
              textScaleFactor: kTextScaleFactor,
              style: TextStyle(color: color, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
