import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';

import 'game.dart';
import 'game_controller.dart';
import 'level.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<GameController>(GameController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Card Memory Game',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GameController _gameController;
  bool _isPlaying = false;
  bool _gameEnded = false;
  int _ticks = 0;

  @override
  void initState() {
    super.initState();
    _gameController = getIt.get<GameController>();
    _gameController.onTickTimer = (v) => setState(() => _ticks = v.tick);
    _gameController.onGameEnd = () => setState(() => _gameEnded = true);
  }

  void onPlayAgainPressed() {
    setState(() {
      _isPlaying = false;
      _gameEnded = false;
      _ticks = 0;
    });
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
              if (!_isPlaying)
                const Text(
                  'Select a level: ',
                  textAlign: TextAlign.center,
                ),
              if (!_isPlaying) const SizedBox(height: 10),
              if (!_isPlaying)
                ...Level.values
                    .map(
                      (level) => ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isPlaying = true;
                            _gameController.level = level;
                          });
                          _gameController.startGame();
                        },
                        child: Text(level.name.toUpperCase()),
                      ),
                    )
                    .toList(),
              if (_isPlaying)
                const Expanded(
                  child: AnimationLimiter(child: Game()),
                ),
              if (_gameEnded)
                Text(
                  'Congratulations, you spent $_ticks seconds!!!',
                  style: const TextStyle(fontSize: 16),
                ),
              if (_gameEnded)
                ElevatedButton(
                  onPressed: onPlayAgainPressed,
                  child: const Text('Play again'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
