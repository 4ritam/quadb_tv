import 'package:get_it/get_it.dart';
import 'package:quadb_tv/domain/usecases/get_season_episodes.dart';
import 'package:quadb_tv/domain/usecases/get_seasons.dart';
import 'package:quadb_tv/domain/usecases/get_show_cast.dart';
import 'package:quadb_tv/domain/usecases/get_show_episodes.dart';
import 'package:quadb_tv/domain/usecases/search_shows.dart';

import 'domain/usecases/get_all_shows.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => GetAllShows(sl()));
  sl.registerLazySingleton(() => SearchShows(sl()));
  sl.registerLazySingleton(() => GetShowSeasons(sl()));
  sl.registerLazySingleton(() => GetShowEpisodes(sl()));
  sl.registerLazySingleton(() => GetSeasonEpisodes(sl()));
  sl.registerLazySingleton(() => GetShowCast(sl()));
}
