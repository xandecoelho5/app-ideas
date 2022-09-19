import 'package:card_memory_game/card_model.dart';
import 'package:card_memory_game/game_controller.dart';
import 'package:card_memory_game/main.dart';
import 'package:flutter/material.dart';

class MemoryCard extends StatelessWidget {
  const MemoryCard({
    Key? key,
    required this.card,
    required this.onTap,
  }) : super(key: key);

  final CardModel card;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: card.visible ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(color: Colors.black),
        ),
        child: Visibility(
          visible: !card.hidden,
          child: Center(
            child: Icon(
              card.icon,
              size: getIt.get<GameController>().level.iconSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
