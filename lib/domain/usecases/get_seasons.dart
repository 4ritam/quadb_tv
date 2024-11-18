import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quadb_tv/domain/entities/season.dart';

import '../../core/errors/failures.dart';
import '../../core/utils/usecase.dart';
import '../irepositories/show_repository.dart';

class ShowSeasonsParams extends Equatable {
  final int showId;

  const ShowSeasonsParams({required this.showId});

  @override
  List<Object?> get props => [showId];
}

class GetShowSeasons implements UseCase<List<Season>, ShowSeasonsParams> {
  final ShowRepository repository;

  GetShowSeasons(this.repository);

  @override
  Future<Either<Failure, List<Season>>> call(ShowSeasonsParams params) async {
    return await repository.getShowSeasons(params.showId);
  }
}
