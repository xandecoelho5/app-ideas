import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:github_timeline/controllers/repository_controller.dart';
import 'package:github_timeline/screens/home_screen.dart';
import 'package:github_timeline/services/repository_service.dart';
import 'package:github_timeline/utils/constants.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<RepositoryService>(
    RepositoryService(Dio(BaseOptions(baseUrl: 'https://api.github.com'))),
  );
  getIt.registerSingleton<RepositoryController>(
    RepositoryController(getIt<RepositoryService>()),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Timeline',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: kHeaderColor,
          secondary: kInputTextColor,
        ),
        scaffoldBackgroundColor: kBackgroundColor,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          fillColor: kInputBackgroundColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          filled: true,
          labelStyle: const TextStyle(color: kInputTextColor),
          iconColor: kInputTextColor,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: kInputTextColor,
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
