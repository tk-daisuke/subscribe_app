import 'package:auto_size_text/auto_size_text.dart';
import 'package:bom_app/constants.dart';
import 'package:flutter/material.dart';

class ExpandedCell extends StatelessWidget {
  const ExpandedCell({
    required this.title,
    required this.contents,
  });
  final String title;
  final String contents;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: AutoSizeText(
            title,
            textScaleFactor: kTextScaleFactor,
            maxLines: 1,
            maxFontSize: 16,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: AutoSizeText(
            contents,
            textScaleFactor: kTextScaleFactor,
            maxFontSize: 16,
            maxLines: 5,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
