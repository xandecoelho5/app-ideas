import 'package:card_memory_game/statistic_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'game_controller.dart';
import 'home_screen.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<GameController>(GameController());
  getIt.registerSingleton<StatisticController>(StatisticController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return const MaterialApp(
      title: 'Card Memory Game',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
