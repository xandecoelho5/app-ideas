import 'package:flutter/material.dart';

class CardModel {
  final IconData? icon;
  bool hidden;
  bool visible;

  CardModel({
    required this.icon,
    this.hidden = true,
    this.visible = false,
  });

  @override
  String toString() {
    return 'CardModel{icon: $icon, hidden: $hidden}';
  }
}
