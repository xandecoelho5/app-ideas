import 'package:flutter/material.dart';
import 'package:github_timeline/components/search_bar.dart';
import 'package:github_timeline/controllers/repository_controller.dart';
import 'package:github_timeline/main.dart';
import 'package:github_timeline/utils/constants.dart';

import '../components/repositories_list.dart';
import '../components/repository_summary.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  bool _generateButtonPressed = false;
  bool _isLoading = false;

  void onGeneratePressed() async {
    setState(() {
      _generateButtonPressed = true;
      _isLoading = true;
    });

    final result = await getIt
        .get<RepositoryController>()
        .fetchRepositories(_searchController.text);
    result.fold(
        (l) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l.toString()),
                backgroundColor: Colors.red,
              ),
            ),
        (r) {});
    setState(() => _isLoading = false);
  }

  void onSummarizePressed() {
    showDialog(
      context: context,
      builder: (context) => const RepositorySummary(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Timeline'),
        actions: [
          IconButton(
            onPressed: getIt.get<RepositoryController>().value.isEmpty
                ? null
                : onSummarizePressed,
            icon: const Icon(Icons.summarize),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 3),
            child: SearchBar(controller: _searchController),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: ElevatedButton(
              onPressed: onGeneratePressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: kButtonBackgroundColor,
                foregroundColor: kButtonTextColor,
                side: const BorderSide(color: kButtonBorderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text('Generate'),
            ),
          ),
          if (_generateButtonPressed)
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Center(child: CircularProgressIndicator()),
              )
            else
              const RepositoriesList(),
        ],
      ),
    );
  }
}
