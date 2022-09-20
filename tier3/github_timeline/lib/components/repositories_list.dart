import 'package:flutter/material.dart';
import 'package:github_timeline/components/repository_timeline.dart';
import 'package:github_timeline/controllers/repository_controller.dart';
import 'package:github_timeline/main.dart';

class RepositoriesList extends StatelessWidget {
  const RepositoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: getIt.get<RepositoryController>(),
        builder: (context, repositories, _) {
          if (repositories.isEmpty) {
            return const Center(child: Text('No repositories found'));
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
            itemCount: repositories.length,
            itemBuilder: (ctx, i) =>
                // RepositoryItem(repository: repositories[i]),
                RepositoryTimeline(
              repository: repositories[i],
              index: i,
              isLast: i == repositories.length - 1,
            ),
            separatorBuilder: (ctx, i) => const SizedBox(height: 0),
          );
        },
      ),
    );
  }
}
