import 'package:border_radius_preview/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Border Radius Previewer',
      home: const HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  final _topLeftController = TextEditingController();
  final _topRightController = TextEditingController();
  final _bottomLeftController = TextEditingController();
  final _bottomRightController = TextEditingController();

  late BorderRadius borderRadius;

  onTopLeftChanged(String v) => setState(() {});

  onTopRightChanged(String v) => setState(() {});

  onBottomLeftChanged(String v) => setState(() {});

  onBottomRightChanged(String v) => setState(() {});

  onResetPressed() => setState(() {
        _topLeftController.clear();
        _topRightController.clear();
        _bottomLeftController.clear();
        _bottomRightController.clear();
      });

  onCopyPressed() {
    Clipboard.setData(ClipboardData(text: borderRadius.toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    borderRadius = BorderRadius.only(
      topLeft: Radius.circular(
        double.tryParse(_topLeftController.text) ?? 0,
      ),
      topRight: Radius.circular(
        double.tryParse(_topRightController.text) ?? 0,
      ),
      bottomLeft: Radius.circular(
        double.tryParse(_bottomLeftController.text) ?? 0,
      ),
      bottomRight: Radius.circular(
        double.tryParse(_bottomRightController.text) ?? 0,
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Border Radius Previewer')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextField(
                    onChanged: onTopLeftChanged,
                    controller: _topLeftController,
                  ),
                  CustomTextField(
                    onChanged: onTopRightChanged,
                    controller: _topRightController,
                  ),
                ],
              ),
              Container(
                width: 175,
                height: 175,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: borderRadius,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextField(
                    onChanged: onBottomLeftChanged,
                    controller: _bottomLeftController,
                  ),
                  CustomTextField(
                    onChanged: onBottomRightChanged,
                    controller: _bottomRightController,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: onResetPressed,
                child: const Text('Reset'),
              ),
              ElevatedButton(
                onPressed: onCopyPressed,
                child: const Text('Copy values'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
