import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../core/errors/failures.dart';
import '../../core/utils/usecase.dart';
import '../entities/show.dart';
import '../irepositories/show_repository.dart';

class SearchShowsParams extends Equatable {
  final String query;

  const SearchShowsParams({required this.query});

  @override
  List<Object?> get props => [query];
}

class SearchShows implements UseCase<List<Show>, SearchShowsParams> {
  final ShowRepository repository;

  SearchShows(this.repository);

  @override
  Future<Either<Failure, List<Show>>> call(SearchShowsParams params) async {
    return await repository.searchShows(params.query);
  }
}
