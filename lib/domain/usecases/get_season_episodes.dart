import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../core/errors/failures.dart';
import '../../core/utils/usecase.dart';
import '../entities/episode.dart';
import '../irepositories/show_repository.dart';

class SeasonEpisodesParams extends Equatable {
  final int seasonId;

  const SeasonEpisodesParams({required this.seasonId});

  @override
  List<Object?> get props => [seasonId];
}

class GetSeasonEpisodes
    implements UseCase<List<Episode>, SeasonEpisodesParams> {
  final ShowRepository repository;

  GetSeasonEpisodes(this.repository);

  @override
  Future<Either<Failure, List<Episode>>> call(
      SeasonEpisodesParams params) async {
    return await repository.getSeasonEpisodes(params.seasonId);
  }
}
