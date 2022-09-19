import 'dart:math';

import 'package:card_memory_game/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'card_model.dart';
import 'game_controller.dart';
import 'memory_card.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> with TickerProviderStateMixin {
  final gameController = getIt.get<GameController>();
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    gameController.addOnGameEndListener((won) {
      if (controller.isAnimating) {
        controller.stop();
      }
    });
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: gameController.level.timeLimit),
    )..addListener(() => setState(() {}));
    controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: controller.value,
              minHeight: 8,
            ),
            const SizedBox(height: 5),
            Expanded(
              child: AnimationLimiter(
                child: ValueListenableBuilder(
                  valueListenable: gameController,
                  builder: (context, List<CardModel> cards, child) {
                    final columns = sqrt(gameController.value.length).toInt();

                    return GridView.builder(
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
