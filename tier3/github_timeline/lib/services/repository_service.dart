import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/repository.dart';

class RepositoryService {
  final Dio dio;

  RepositoryService(this.dio);

  Future<Either<String, List<Repository>>> getRepositories(
      String username) async {
    try {
      final response = await dio.get('/users/$username/repos');
      final list = response.data as List;
      final repoList = list.map((e) => Repository.fromMap(e)).toList();
      repoList.sort((a, b) {
        final aDate = DateTime.parse(a.createdAt);
        final bDate = DateTime.parse(b.createdAt);
        return bDate.compareTo(aDate);
      });

      return right(repoList);
    } catch (e) {
      return left('User not found!');
    }
  }
}
