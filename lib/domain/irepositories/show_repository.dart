import 'package:fpdart/fpdart.dart';
import 'package:quadb_tv/domain/entities/season.dart';
import '../entities/show.dart';
import '../entities/episode.dart';
import '../entities/cast.dart';
import '../../core/errors/failures.dart';

abstract interface class ShowRepository {
  Future<Either<Failure, List<Show>>> getAllShows();
  Future<Either<Failure, List<Show>>> searchShows(String query);
  Future<Either<Failure, List<Episode>>> getShowEpisodes(int showId,
      {bool includeSpecials = false});
  Future<Either<Failure, List<Season>>> getShowSeasons(int showId);
  Future<Either<Failure, List<Episode>>> getSeasonEpisodes(int seasonId);
  Future<Either<Failure, List<Cast>>> getShowCast(int showId);
}
