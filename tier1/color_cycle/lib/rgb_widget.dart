import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RGBWidget extends StatefulWidget {
  const RGBWidget({Key? key, required this.onChange}) : super(key: key);

  final Function(Color) onChange;

  @override
  State<RGBWidget> createState() => _RGBWidgetState();
}

class _RGBWidgetState extends State<RGBWidget> {
  final redController = TextEditingController();
  final greenController = TextEditingController();
  final blueController = TextEditingController();
  final incController = TextEditingController();
  final intervalController = TextEditingController();

  Timer? timer;
  bool isRunning = false;

  textField(String label, TextEditingController controller,
      [bool isHexadecimal = true]) {
    return Flexible(
      fit: FlexFit.loose,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            isCollapsed: true,
            contentPadding: const EdgeInsets.only(top: 6, left: 8, bottom: 6),
          ),
          inputFormatters: isHexadecimal
              ? [
                  LengthLimitingTextInputFormatter(2),
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9a-fA-F]')),
                ]
              : [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
          keyboardType: TextInputType.number,
          onChanged: (text) => setState(() => widget.onChange(changeColor())),
          enabled: !isRunning,
        ),
      ),
    );
  }

  String getIncrementedValue(String s, int inc) {
    final value = int.tryParse(s, radix: 16) ?? 0;
    final newValue = (value + inc) % 256;
    return newValue.toRadixString(16);
  }

  onStartCycle() {
    if (timer == null || !timer!.isActive) {
      if (intervalController.text.isEmpty) {
        intervalController.text = '250';
      }
      if (incController.text.isEmpty) {
        incController.text = '1';
      }

      isRunning = true;
      timer = Timer.periodic(
          Duration(
            milliseconds: int.parse(intervalController.text),
          ), (timer) {
        setState(() {
          final inc = int.tryParse(incController.text, radix: 16) ?? 0;
          redController.text = getIncrementedValue(redController.text, inc);
          greenController.text = getIncrementedValue(greenController.text, inc);
          blueController.text = getIncrementedValue(blueController.text, inc);
          widget.onChange(changeColor());
        });
      });
    }
  }

  onStopCycle() {
    if (timer != null && timer!.isActive) {
      setState(() {
        isRunning = false;
        timer!.cancel();
      });
    }
  }

  changeColor() => Color.fromRGBO(
        int.tryParse(redController.text, radix: 16) ?? 0,
        int.tryParse(greenController.text, radix: 16) ?? 0,
        int.tryParse(blueController.text, radix: 16) ?? 0,
        1,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            textField('Red', redController),
            textField('Green', greenController),
            textField('Blue', blueController),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            textField('Incremental Value', incController),
            textField('Interval', intervalController, false),
          ],
        ),
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: isRunning ? onStopCycle : onStartCycle,
          child: Text(isRunning ? 'Stop' : 'Start'),
        ),
      ],
    );
  }
}
