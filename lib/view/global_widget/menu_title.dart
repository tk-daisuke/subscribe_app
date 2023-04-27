import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MenuTitle extends StatelessWidget {
  const MenuTitle({
    required this.sized,
    required this.title,
  });

  final Size sized;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: sized.width * 0.1, bottom: sized.height * 0.005),
          child: AutoSizeText(
            title,
          ),
        ),
      ],
    );
  }
}
