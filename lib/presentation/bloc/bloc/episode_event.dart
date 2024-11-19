part of 'episode_bloc.dart';

sealed class EpisodeEvent extends Equatable {
  const EpisodeEvent();

  @override
  List<Object> get props => [];
}

final class LoadEpisodes extends EpisodeEvent {
  final Show show;
  final List<Season> seasons;

  const LoadEpisodes({
    required this.show,
    required this.seasons,
  });

  @override
  List<Object> get props => [show, seasons];
}

final class LoadSeasonEpisodes extends EpisodeEvent {
  final Season season;

  const LoadSeasonEpisodes({
    required this.season,
  });

  @override
  List<Object> get props => [season];
}
