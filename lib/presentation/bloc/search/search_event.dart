part of 'search_bloc.dart';

@immutable
sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class PerformNameSearch extends SearchEvent {
  final String query;

  const PerformNameSearch(this.query);

  @override
  List<Object> get props => [query];
}

class PerformEmptyLoad extends SearchEvent {
  const PerformEmptyLoad();
}
