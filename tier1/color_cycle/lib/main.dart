import 'package:color_cycle/hsl_widget.dart';
import 'package:color_cycle/rgb_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Cycle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  bool isHSL = false;
  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Color Cycle')),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('Color Encoding', style: TextStyle(fontSize: 20)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isHSL ? 'HSL' : 'RGB',
                  style: const TextStyle(fontSize: 20),
                ),
                Switch(
                  value: isHSL,
                  onChanged: (value) {
                    setState(() => isHSL = value);
                  },
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 15),
              width: 200,
              height: 200,
              color: color,
            ),
            if (isHSL)
              HSLWidget(onChange: (c) => setState(() => color = c))
            else
              RGBWidget(onChange: (c) => setState(() => color = c)),
          ],
        ),
      ),
    );
  }
}
