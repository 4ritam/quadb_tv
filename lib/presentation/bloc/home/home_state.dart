part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeSuccess extends HomeState {
  final List<Show> shows;

  const HomeSuccess(this.shows);

  @override
  List<Object> get props => [shows];
}

final class HomeFailure extends HomeState {
  final Failure failure;

  const HomeFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
