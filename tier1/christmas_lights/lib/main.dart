import 'package:christmas_lights/opacity_controller.dart';
import 'package:flutter/material.dart';

import 'light_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Christmas Lights',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
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
  final controller = OpacityController();
  final colors = [
    Colors.red,
    Colors.purple,
    Colors.blue,
    Colors.lightBlue,
    Colors.green,
    Colors.lightGreen,
    Colors.yellow,
  ];

  int rows = 7;

  lightsRow(bool lastRow) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        separatorBuilder: (context, index) => const SizedBox(width: 5),
        itemBuilder: (context, index) {
          return ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, opacity, child) {
              return LightWidget(
                opacity: opacity,
                color: colors[index],
                lastRow: lastRow,
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Christmas Lights'),
        actions: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () => controller.start(),
          ),
          IconButton(
            icon: const Icon(Icons.stop),
            onPressed: () => controller.stop(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: ListView.separated(
          itemCount: rows,
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          itemBuilder: (context, index) => lightsRow(index == rows - 1),
        ),
      ),
    );
  }
}
