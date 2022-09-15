import 'package:bin2dec/converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Bin2Dec',
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
  final converter = Converter(0);
  final controller = TextEditingController();

  void convert() {
    converter.convert(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bin2Dec'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You can only enter the digits 0 or 1'),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Binary Value',
              ),
              controller: controller,
              onChanged: (s) => setState(() {}),
              onSubmitted: (_) => convert(),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[01]')),
                // LengthLimitingTextInputFormatter(16),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: controller.text.isEmpty ? null : convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder(
              valueListenable: converter,
              builder: (context, value, child) => Text(
                'Decimal Value: ${controller.text.isEmpty ? '' : value}',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
