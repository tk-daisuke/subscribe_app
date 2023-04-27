import 'package:bom_app/constants.dart';
import 'package:flutter/material.dart';

class SubscribeIcon extends StatelessWidget {
  const SubscribeIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kPrimaryColor,
      child: Icon(
        icon,
        size: 35,
        color: Colors.black,
      ),
    );
  }
}
