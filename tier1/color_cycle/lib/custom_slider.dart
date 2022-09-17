import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    Key? key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 1,
    this.divisions = 10,
  }) : super(key: key);

  final double value;
  final double min;
  final double max;
  final int divisions;
  final Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Slider(
        value: value,
        min: min,
        max: max,
        onChanged: onChanged,
        label: value.toStringAsFixed(2),
        divisions: divisions,
      ),
    );
  }
}
