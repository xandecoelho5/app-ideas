import 'package:card_memory_game/level.dart';
import 'package:card_memory_game/statistic.dart';

class StatisticController {
  final _statistic = Statistic();

  int get timesPlayed => _statistic.plays;

  int get wins => _statistic.wins;

  int get loses => _statistic.loses;

  int getBestTimeByLevel(Level level) => _statistic.bestTimeByLevel[level]!;

  void updateTime(Level level, int time) {
    if (_statistic.bestTimeByLevel[level] == 0 ||
        _statistic.bestTimeByLevel[level]! > time) {
      _statistic.bestTimeByLevel[level] = time;
    }
  }

  void updateStatistic(bool win) {
    _statistic.plays++;
    if (win) {
      _statistic.wins++;
    } else {
      _statistic.loses++;
    }
  }
}
