import 'package:card_memory_game/level.dart';
import 'package:card_memory_game/statistic_controller.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class StatisticWidget extends StatelessWidget {
  const StatisticWidget({Key? key}) : super(key: key);

  detailsRow(label, value) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<StatisticController>();

    return SizedBox(
      height: 165,
      child: Column(
        children: [
          detailsRow('Times played: ', controller.timesPlayed.toString()),
          detailsRow('Wins: ', controller.wins.toString()),
          detailsRow('Loses: ', controller.loses.toString()),
          const SizedBox(height: 15),
          const Text(
            'Best times (In seconds):',
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 6),
          ...Level.values
              .where((level) => controller.getBestTimeByLevel(level) > 0)
              .map((level) {
            return detailsRow(
              '${level.description}: ',
              '${controller.getBestTimeByLevel(level)}s',
            );
          }).toList(),
        ],
      ),
    );
  }
}
