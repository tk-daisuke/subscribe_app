import 'package:flutter/material.dart';

class TitleIcon extends StatelessWidget {
  const TitleIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Icon(
        icon,
        size: 36,
        color: Colors.black,
      ),
    );
  }
}
