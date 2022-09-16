import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.onChanged,
    required this.controller,
  }) : super(key: key);

  final Function(String)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 30,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        inputFormatters: [
          LengthLimitingTextInputFormatter(3),
        ],
        controller: controller,
        onChanged: onChanged,
      ),
    );
  }
}
