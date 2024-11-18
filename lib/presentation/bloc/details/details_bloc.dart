import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadb_tv/domain/usecases/get_season_episodes.dart';
import 'package:quadb_tv/domain/usecases/get_seasons.dart';
import 'package:quadb_tv/domain/usecases/get_show_cast.dart';
import 'package:quadb_tv/domain/usecases/get_show_episodes.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/entities/cast.dart';
import '../../../domain/entities/episode.dart';
import '../../../domain/entities/season.dart';
import '../../../domain/entities/show.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final GetShowEpisodes getShowEpisodes;
  final GetShowSeasons getShowSeasons;
  final GetSeasonEpisodes getSeasonEpisodes;
  final GetShowCast getShowCast;

  DetailsBloc({
    required this.getShowEpisodes,
    required this.getShowSeasons,
    required this.getSeasonEpisodes,
    required this.getShowCast,
  }) : super(DetailsInitial()) {
    on<LoadShowDetails>(_onLoadShowDetails);
  }

  void _onLoadShowDetails(
    LoadShowDetails event,
    Emitter<DetailsState> emit,
  ) async {
    emit(const DetailsLoading());

    final castResults = await getShowCast(
      ShowCastParams(showId: event.show.id),
    );

    final seasonResult = await getShowSeasons(
      ShowSeasonsParams(showId: event.show.id),
    );

    await castResults.fold(
      (failure) {
        emit(DetailsFailure(failure));
      },
      (cast) async {
        await seasonResult.fold(
          (failure) {
            emit(DetailsFailure(failure));
          },
          (seasons) async {
            if (seasons.isNotEmpty) {
              final seasonEpisodes = <Season, List<Episode>>{};

              for (final season in seasons) {
                final episodesResult = await getSeasonEpisodes(
                  SeasonEpisodesParams(seasonId: season.id),
                );

                episodesResult.fold(
                  (failure) {
                    emit(DetailsFailure(failure));
                  },
                  (episodes) {
                    seasonEpisodes[season] = episodes;
                  },
                );
              }

              emit(DetailsSuccess(
                show: event.show,
                cast: cast,
                seasons: seasons,
                seasonEpisodes: seasonEpisodes,
              ));
            } else {
              final episodesResult = await getShowEpisodes(
                ShowEpisodesParams(showId: event.show.id),
              );

              episodesResult.fold(
                (failure) {
                  emit(DetailsFailure(failure));
                },
                (episodes) {
                  emit(DetailsSuccess(
                    show: event.show,
                    cast: cast,
                    episodes: episodes,
                  ));
                },
              );
            }
          },
        );
      },
    );
  }
}
