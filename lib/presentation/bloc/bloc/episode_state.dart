part of 'episode_bloc.dart';

sealed class EpisodeState extends Equatable {
  const EpisodeState();

  @override
  List<Object> get props => [];
}

final class EpisodeInitial extends EpisodeState {
  const EpisodeInitial();
}

final class EpisodeLoading extends EpisodeState {
  const EpisodeLoading();
}

final class EpisodeSuccess extends EpisodeState {
  final Season? currentSeason;
  final List<Episode> episodes;

  const EpisodeSuccess({
    this.currentSeason,
    required this.episodes,
  });

  @override
  List<Object> get props => [episodes];
}

final class EpisodeFailure extends EpisodeState {
  final Failure failure;

  const EpisodeFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
