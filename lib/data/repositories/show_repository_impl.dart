import 'package:fpdart/fpdart.dart';
import '../../core/errors/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/irepositories/show_repository.dart';
import '../datasources/show_remote_datasource.dart';
import '../models/cast_model.dart';
import '../models/episode_model.dart';
import '../models/season_model.dart';
import '../models/show_model.dart';

class ShowRepositoryImpl implements ShowRepository {
  final ShowRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ShowRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ShowModel>>> getAllShows() async {
    if (await networkInfo.isConnected) {
      try {
        final shows = await remoteDataSource.getAllShows();
        return Right(shows);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<ShowModel>>> searchShows(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final shows = await remoteDataSource.searchShows(query);
        return Right(shows);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<SeasonModel>>> getShowSeasons(int showId) async {
    if (await networkInfo.isConnected) {
      try {
        final seasons = await remoteDataSource.getShowSeasons(showId);
        return Right(seasons);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<EpisodeModel>>> getShowEpisodes(
    int showId, {
    bool includeSpecials = false,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final episodes = await remoteDataSource.getShowEpisodes(
          showId,
          includeSpecials: includeSpecials,
        );
        return Right(episodes);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<EpisodeModel>>> getSeasonEpisodes(
    int seasonId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final episodes = await remoteDataSource.getSeasonEpisodes(seasonId);
        return Right(episodes);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<CastModel>>> getShowCast(int showId) async {
    if (await networkInfo.isConnected) {
      try {
        final cast = await remoteDataSource.getShowCast(showId);
        return Right(cast);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
