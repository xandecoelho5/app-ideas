import 'package:flutter/material.dart';

import 'custom_slider.dart';

class HSLWidget extends StatefulWidget {
  const HSLWidget({Key? key, required this.onChange}) : super(key: key);

  final Function(Color) onChange;

  @override
  State<HSLWidget> createState() => _HSLWidgetState();
}

class _HSLWidgetState extends State<HSLWidget> {
  double hue = 0;
  double saturation = 1;
  double lightness = 1;

  changeColor() => HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();

  paddedText(String text) => Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      );

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(fit: FlexFit.loose, child: paddedText('Hue')),
          CustomSlider(
            value: hue,
            onChanged: (value) => setState(() {
              hue = value;
              widget.onChange(changeColor());
            }),
            min: 0,
            max: 360,
            divisions: 360,
          ),
          Row(
            children: [
              Expanded(child: paddedText('Saturation')),
              Expanded(child: paddedText('Lightness')),
            ],
          ),
          Row(
            children: [
              CustomSlider(
                value: saturation,
                onChanged: (value) => setState(() {
                  saturation = value;
                  widget.onChange(changeColor());
                }),
              ),
              CustomSlider(
                value: lightness,
                onChanged: (value) => setState(() {
                  lightness = value;
                  widget.onChange(changeColor());
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
