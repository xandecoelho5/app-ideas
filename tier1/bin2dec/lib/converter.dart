import 'package:flutter/cupertino.dart';

class Converter extends ValueNotifier<int> {
  Converter() : super(0);

  void convert(String binary) {
    value = int.parse(binary, radix: 2);
  }
}
