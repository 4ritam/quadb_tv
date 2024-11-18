part of 'search_bloc.dart';

@immutable
sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {
  const SearchInitial();
}

final class SearchLoading extends SearchState {
  const SearchLoading();
}

final class SearchSuccess extends SearchState {
  final List<Show> shows;

  const SearchSuccess(this.shows);

  @override
  List<Object> get props => [shows];
}

final class SearchFailure extends SearchState {
  final Failure failure;

  const SearchFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
