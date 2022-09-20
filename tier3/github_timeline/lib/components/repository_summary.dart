import 'package:flutter/material.dart';
import 'package:github_timeline/controllers/repository_controller.dart';
import 'package:github_timeline/utils/constants.dart';

import '../main.dart';

class RepositorySummary extends StatelessWidget {
  const RepositorySummary({Key? key}) : super(key: key);

  List _buildSummary() {
    final result = [];

    getIt.get<RepositoryController>().retrieveSummary().forEach((key, value) {
      result.add(Row(
        children: [
          Text(
            '$key: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            value.toString(),
            style: const TextStyle(color: kButtonTextColor, fontSize: 18),
          ),
        ],
      ));
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Repositories Summary By Year'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [..._buildSummary()],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
