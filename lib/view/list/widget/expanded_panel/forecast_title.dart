import 'package:bom_app/view/list/widget/expanded_view.dart';
import 'package:flutter/material.dart';

class ForecastTitle extends StatelessWidget {
  const ForecastTitle({
    Key? key, required this.title, required this.snackText,
  }) : super(key: key);

  final String title;
  final String snackText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children:  [
         ExpandedPanelTitle(
          icon: Icons.assessment_outlined,
          title: title,
        ),
         InfoButton(
          reading: snackText,
        ),
      ],
    );
  }
}
