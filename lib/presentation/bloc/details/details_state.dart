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
  final List<Cast> cast;

  final List<Season> seasons;

  const DetailsSuccess({
    required this.show,
    required this.seasons,
    required this.cast,
  });

  @override
  List<Object> get props => [show];
}

final class DetailsFailure extends DetailsState {
  final Failure failure;

  const DetailsFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
