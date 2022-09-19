import 'dart:async';
import 'dart:math';

import 'package:card_memory_game/card_model.dart';
import 'package:card_memory_game/level.dart';
import 'package:card_memory_game/stubs.dart';
import 'package:flutter/material.dart';

class GameController extends ValueNotifier<List<CardModel>> {
  List<IconData> icons = [];
  List<CardModel> chosenCards = [];
  List<Function> onGameEndListeners = [];
  late Level level;

  final random = Random();
  Timer? timer;
  bool _canPress = true;

  Function(Timer)? onTickTimer;

  GameController() : super([]);

  int get ticks => timer!.tick ~/ 10;

  void generateCards(int count) {
    icons = baseIcons.take(count).toList();
    value = List.generate(count, (i) => CardModel(icon: _getIcon()));
  }

  IconData? _getIcon() {
    if (icons.isNotEmpty) {
      final icon = icons[random.nextInt(icons.length)];
      icons.remove(icon);
      return icon;
    }
    return null;
  }

  void startGame() {
    if (timer == null || !timer!.isActive) {
      _canPress = true;
      generateCards(level.columns * level.columns);
      timer = Timer.periodic(const Duration(milliseconds: 100), (val) {
        _verifyWin();
      });
    }
  }

  Future<void> onCardPress(CardModel card) async {
    if (_canPress) {
      if (chosenCards.contains(card) || card.visible) return;

      _canPress = false;

      card.hidden = false;
      chosenCards.add(card);
      notifyListeners();

      if (chosenCards.length == 2) {
        await _verifyPair();
        _canPress = true;
        _verifyWin();
      } else {
        _canPress = true;
      }
    }
  }

  Future<void> _verifyPair() async {
    if (chosenCards[0].icon != chosenCards[1].icon) {
      await Future.delayed(const Duration(milliseconds: 500));
      chosenCards[0].hidden = true;
      chosenCards[1].hidden = true;
    } else {
      await Future.delayed(const Duration(milliseconds: 300));
      chosenCards[0].visible = true;
      chosenCards[1].visible = true;
    }
    chosenCards = [];
    notifyListeners();
  }

  void _verifyWin() {
    final bool allVisible = value.every((element) => element.visible);
    if (allVisible || !allVisible && timer!.tick >= (level.timeLimit ~/ 100)) {
      _canPress = false;
      timer?.cancel();
      _executeOnGameEndListeners(allVisible);
    }
  }

  void addOnGameEndListener(Function(bool) listener) {
    onGameEndListeners.add(listener);
  }

  void _executeOnGameEndListeners(bool won) {
    for (var element in onGameEndListeners) {
      element(won);
    }
  }
}
