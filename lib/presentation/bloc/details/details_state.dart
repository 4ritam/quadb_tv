part of 'details_bloc.dart';

sealed class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

final class DetailsInitial extends DetailsState {
  const DetailsInitial();
}

final class DetailsLoading extends DetailsState {
  const DetailsLoading();
}

final class DetailsSuccess extends DetailsState {
  final Show show;
  final List<Season>? seasons;
  final List<Episode>? episodes;
  final Map<Season, List<Episode>>? seasonEpisodes;
  final List<Cast> cast;

  const DetailsSuccess({
    required this.show,
    this.seasons,
    this.seasonEpisodes,
    this.episodes,
    required this.cast,
  });

  @override
  List<Object> get props => [show, cast];
}

final class DetailsFailure extends DetailsState {
  final Failure failure;

  const DetailsFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
