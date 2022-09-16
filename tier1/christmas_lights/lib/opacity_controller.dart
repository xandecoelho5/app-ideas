import 'dart:async';

import 'package:flutter/cupertino.dart';

class OpacityController extends ValueNotifier<double> {
  OpacityController() : super(0.0);

  Timer? timer;

  void start() {
    if (timer == null || !timer!.isActive) {
      int ticks = 0;
      bool dec = false;
      bool canChange = true;
      timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
        if (value >= 1.0) {
          // value = 1.0;
          dec = true;
          canChange = false;
          ticks++;
          if (ticks == 30) {
            ticks = 0;
            canChange = true;
          }
        } else if (value <= 0.0) {
          // value = 0.0;
          dec = false;
          canChange = false;
          ticks++;
          if (ticks == 10) {
            ticks = 0;
            canChange = true;
          }
        }

        if (canChange) {
          if (dec) {
            decrement();
          } else {
            increment();
          }
        }
      });
    }
  }

  void increment() => value += 0.4;

  void decrement() => value -= 0.4;

  void stop() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }
}
