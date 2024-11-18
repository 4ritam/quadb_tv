import 'package:fpdart/fpdart.dart';

import '../../core/errors/failures.dart';
import '../../core/utils/usecase.dart';
import '../entities/episode.dart';
import '../irepositories/show_repository.dart';

class GetShowEpisodes implements UseCase<List<Episode>, int> {
  final ShowRepository repository;

  GetShowEpisodes(this.repository);

  @override
  Future<Either<Failure, List<Episode>>> call(
    int showId, {
    bool includeSpecials = false,
  }) async {
    return await repository.getShowEpisodes(showId,
        includeSpecials: includeSpecials);
  }
}
