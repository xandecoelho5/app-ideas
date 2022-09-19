import 'dart:math';

import 'package:card_memory_game/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'card_model.dart';
import 'game_controller.dart';
import 'memory_card.dart';

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameController = getIt.get<GameController>();

    return ValueListenableBuilder(
      valueListenable: gameController,
      builder: (context, List<CardModel> cards, child) {
        final columns = sqrt(gameController.value.length).toInt();

        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: cards.length,
          itemBuilder: (context, i) {
            return AnimationConfiguration.staggeredGrid(
              position: i,
              duration: const Duration(milliseconds: 500),
              columnCount: columns,
              child: FadeInAnimation(
                child: MemoryCard(
                  card: cards[i],
                  onTap: () => gameController.onCardPress(cards[i]),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
