import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_timeline/models/repository.dart';

import '../services/repository_service.dart';

class RepositoryController extends ValueNotifier<List<Repository>> {
  final RepositoryService repositoryService;

  RepositoryController(this.repositoryService) : super([]);

  Future<Either<String, void>> fetchRepositories(String username) async {
    final result = await repositoryService.getRepositories(username);
    result.fold((l) => value = [], (r) => value = r);
    return result.leftMap((l) => l);
  }

  Map<int, int> retrieveSummary() {
    final result = <int, int>{};
    for (final year in _yearsList()) {
      result[year] =
          value.where((e) => DateTime.parse(e.createdAt).year == year).length;
    }
    return result;
  }

  Set<int> _yearsList() {
    return value.map((e) => DateTime.parse(e.createdAt).year).toSet();
  }
}
