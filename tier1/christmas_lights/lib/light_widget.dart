import 'package:flutter/material.dart';

class LightWidget extends StatelessWidget {
  LightWidget({
    Key? key,
    required this.opacity,
    required this.color,
    this.lastRow = false,
  }) : super(key: key) {
    // if (opacity < 0.0) {
    //   opacity = opacity * -1;
    // } else if (opacity > 1.0) {
    //   opacity = opacity - 1.0;
    // }

    if (opacity <= 0.0) {
      opacity = 0.0;
    } else if (opacity > 1.0) {
      opacity = 1.0;
    }
  }

  double opacity;
  Color color;
  final bool lastRow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      decoration: BoxDecoration(
        color: color.withOpacity(opacity),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          lastRow
              ? BoxShadow(
                  color: color.withOpacity(opacity),
                  blurRadius: 30,
                  spreadRadius: 10,
                  offset: const Offset(0, 0),
                )
              : BoxShadow(
                  color: color.withOpacity(opacity),
                  blurRadius: 10,
                  spreadRadius: 3,
                ),
        ],
      ),
    );
  }
}
