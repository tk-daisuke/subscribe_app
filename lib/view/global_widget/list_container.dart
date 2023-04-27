import 'package:bom_app/constants.dart';
import 'package:flutter/material.dart';

class ListContainer extends StatelessWidget {
  const ListContainer({required this.sized, required this.child});

  final Size sized;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sized.width * 0.9,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        // kPrimaryColor
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            color: kTextColor.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
