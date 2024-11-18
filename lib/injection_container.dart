import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'core/network/network_info.dart';
import 'data/datasources/show_remote_datasource.dart';
import 'data/repositories/show_repository_impl.dart';
import 'domain/irepositories/show_repository.dart';
import 'domain/usecases/get_all_shows.dart';
import 'domain/usecases/get_season_episodes.dart';
import 'domain/usecases/get_seasons.dart';
import 'domain/usecases/get_show_cast.dart';
import 'domain/usecases/get_show_episodes.dart';
import 'domain/usecases/search_shows.dart';
import 'presentation/bloc/details/details_bloc.dart';
import 'presentation/bloc/home/home_bloc.dart';
import 'presentation/bloc/search/search_bloc.dart';

class DependencyInjection {
  static final sl = GetIt.instance;

  static Future<void> init() async {
    // External
    sl.registerLazySingleton(() => http.Client());
    sl.registerLazySingleton(() => InternetConnection());

    // Core
    sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<InternetConnection>()),
    );

    // Data sources
    sl.registerLazySingleton<ShowRemoteDataSource>(
      () => ShowRemoteDataSourceImpl(
        client: sl<http.Client>(),
      ),
    );

    // Repository
    sl.registerLazySingleton<ShowRepository>(
      () => ShowRepositoryImpl(
        remoteDataSource: sl<ShowRemoteDataSource>(),
        networkInfo: sl<NetworkInfo>(),
      ),
    );

    // Usecases
    sl.registerLazySingleton(() => GetAllShows(sl<ShowRepository>()));
    sl.registerLazySingleton(() => SearchShows(sl<ShowRepository>()));
    sl.registerLazySingleton(() => GetShowSeasons(sl<ShowRepository>()));
    sl.registerLazySingleton(() => GetShowEpisodes(sl<ShowRepository>()));
    sl.registerLazySingleton(() => GetSeasonEpisodes(sl<ShowRepository>()));
    sl.registerLazySingleton(() => GetShowCast(sl<ShowRepository>()));

    // Bloc
    sl.registerFactory(() => HomeBloc(getAllShows: sl<GetAllShows>()));
    sl.registerFactory(() => SearchBloc(searchShows: sl<SearchShows>()));
    sl.registerFactory(
      () => DetailsBloc(
        getShowEpisodes: sl<GetShowEpisodes>(),
        getShowSeasons: sl<GetShowSeasons>(),
        getSeasonEpisodes: sl<GetSeasonEpisodes>(),
        getShowCast: sl<GetShowCast>(),
      ),
    );
  }
}
