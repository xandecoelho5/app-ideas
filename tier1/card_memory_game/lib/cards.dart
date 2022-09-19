import 'package:card_memory_game/card_model.dart';
import 'package:flutter/cupertino.dart';

class Cards extends ValueNotifier<List<CardModel>> {
  Cards(List<CardModel> cards) : super([]);
}
