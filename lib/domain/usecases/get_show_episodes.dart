import 'package:fpdart/fpdart.dart';

import '../../core/errors/failures.dart';
import '../../core/utils/usecase.dart';
import '../entities/episode.dart';
import '../irepositories/show_repository.dart';

class ShowEpisodesParams {
  final int showId;
  final bool includeSpecials;

  ShowEpisodesParams({required this.showId, this.includeSpecials = false});
}

class GetShowEpisodes implements UseCase<List<Episode>, ShowEpisodesParams> {
  final ShowRepository repository;

  GetShowEpisodes(this.repository);

  @override
  Future<Either<Failure, List<Episode>>> call(ShowEpisodesParams params) async {
    return await repository.getShowEpisodes(
      params.showId,
      includeSpecials: params.includeSpecials,
    );
  }
}
