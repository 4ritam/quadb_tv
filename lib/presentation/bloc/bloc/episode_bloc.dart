import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadb_tv/domain/usecases/get_season_episodes.dart';
import 'package:quadb_tv/domain/usecases/get_show_episodes.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/entities/episode.dart';
import '../../../domain/entities/season.dart';
import '../../../domain/entities/show.dart';

part 'episode_event.dart';
part 'episode_state.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final GetShowEpisodes getShowEpisodes;
  final GetSeasonEpisodes getSeasonEpisodes;

  EpisodeBloc({
    required this.getShowEpisodes,
    required this.getSeasonEpisodes,
  }) : super(EpisodeInitial()) {
    on<LoadEpisodes>(_onLoadEpisodes);
    on<LoadSeasonEpisodes>(_onLoadSeasonEpisodes);
  }

  void _onLoadEpisodes(
    LoadEpisodes event,
    Emitter<EpisodeState> emit,
  ) async {
    emit(const EpisodeLoading());

    if (event.seasons.isEmpty) {
      final result = await getShowEpisodes(
        ShowEpisodesParams(showId: event.show.id),
      );

      emit(result.fold(
        (failure) => EpisodeFailure(failure),
        (episodes) => EpisodeSuccess(
          episodes: episodes,
        ),
      ));
    } else {
      final result = await getSeasonEpisodes(
        SeasonEpisodesParams(seasonId: event.seasons[0].id),
      );

      emit(result.fold(
        (failure) => EpisodeFailure(failure),
        (episodes) => EpisodeSuccess(
          currentSeason: event.seasons[0],
          episodes: episodes,
        ),
      ));
    }
  }

  void _onLoadSeasonEpisodes(
    LoadSeasonEpisodes event,
    Emitter<EpisodeState> emit,
  ) async {
    emit(const EpisodeLoading());

    final result = await getSeasonEpisodes(
      SeasonEpisodesParams(seasonId: event.season.id),
    );

    emit(result.fold(
      (failure) => EpisodeFailure(failure),
      (episodes) => EpisodeSuccess(
        currentSeason: event.season,
        episodes: episodes,
      ),
    ));
  }
}
