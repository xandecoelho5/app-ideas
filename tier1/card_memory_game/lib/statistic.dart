import 'level.dart';

class Statistic {
  int plays = 0;
  int wins = 0;
  int loses = 0;
  final Map<Level, int> bestTimeByLevel = {
    Level.easy: 0,
    Level.medium: 0,
    Level.hard: 0,
  };
}
