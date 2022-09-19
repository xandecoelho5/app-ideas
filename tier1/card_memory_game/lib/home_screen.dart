import 'package:card_memory_game/statistic_controller.dart';
import 'package:card_memory_game/statistic_widget.dart';
import 'package:flutter/material.dart';

import 'game.dart';
import 'game_controller.dart';
import 'level.dart';
import 'main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _gameController = getIt.get<GameController>();
  bool _isPlaying = false;
  bool _gameEnded = false;
  String _gameEndMessage = '';

  @override
  void initState() {
    super.initState();

    _gameController.addOnGameEndListener((won) {
      setState(() {
        _gameEnded = true;
        _gameEndMessage = won
            ? 'Congratulations, you spent ${_gameController.ticks} seconds!!!'
            : 'Sorry, you lost!';
      });
      if (won) {
        getIt
            .get<StatisticController>()
            .updateTime(_gameController.level, _gameController.ticks);
      }
      getIt.get<StatisticController>().updateStatistic(won);
    });
  }

  void onPlayAgainPressed() {
    setState(() {
      _isPlaying = false;
      _gameEnded = false;
    });
  }

  void onLevelSelect(Level level) {
    setState(() {
      _isPlaying = true;
      _gameController.level = level;
      _gameController.startGame();
    });
  }

  void onShowStatisticsPressed() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Statistics'),
          content: const StatisticWidget(),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  _levelWidgets() {
    return [
      const Text(
        'Select a level: ',
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 10),
      ...Level.values
          .map(
            (level) => ElevatedButton(
              onPressed: () => onLevelSelect(level),
              child: Text(level.description),
            ),
          )
          .toList(),
      Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          onPressed: onShowStatisticsPressed,
          child: const Text('Show Statistics'),
        ),
      ),
    ];
  }

  _endedGameWidgets() {
    return [
      Text(_gameEndMessage, style: const TextStyle(fontSize: 16)),
      if (_gameEnded)
        ElevatedButton(
          onPressed: onPlayAgainPressed,
          child: const Text('Play again'),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_isPlaying) ..._levelWidgets(),
              if (_isPlaying) const Game(),
              if (_gameEnded) ..._endedGameWidgets(),
            ],
          ),
        ),
      ),
    );
  }
}
