
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({required Size size, required this.child}) : _size = size;

  final Size _size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            child: Image.asset(
              'assets/images/unsplash.com:photos:azyQ0Zd8zaI.jpeg',
              height: _size.height,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
