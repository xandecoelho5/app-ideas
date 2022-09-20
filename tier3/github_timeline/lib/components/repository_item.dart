import 'package:flutter/material.dart';
import 'package:github_timeline/models/repository.dart';
import 'package:github_timeline/utils/constants.dart';

class RepositoryItem extends StatelessWidget {
  const RepositoryItem({Key? key, required this.repository}) : super(key: key);

  final Repository repository;

  String _formatDate(String date) {
    final dateParts = date.split('T')[0].split('-');
    return '${dateParts[2]}/${dateParts[1]}/${dateParts[0]}';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      tileColor: kInputBackgroundColor,
      title: Text(
        repository.name,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      subtitle: Text(
        repository.description,
        style: const TextStyle(color: kInputTextColor, fontSize: 12),
      ),
      trailing: Text(
        _formatDate(repository.createdAt),
        style: const TextStyle(color: kInputTextColor),
      ),
    );
  }
}
