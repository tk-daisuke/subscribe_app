import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BigTitle extends StatelessWidget {
  const BigTitle({required this.icon, required this.title});
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Divider(),
        Row(
          children: <Widget>[
            Icon(icon),
            AutoSizeText(
              title,
              maxFontSize: 20,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
