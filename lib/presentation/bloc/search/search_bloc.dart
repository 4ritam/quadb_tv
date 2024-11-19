import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/entities/show.dart';
import '../../../domain/usecases/search_shows.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchShows searchShows;
  SearchBloc({required this.searchShows}) : super(SearchInitial()) {
    on<PerformNameSearch>(_onPerformSearch);
    on<PerformEmptyLoad>(_onPerformEmptyLoad);
  }

  void _onPerformEmptyLoad(
      PerformEmptyLoad event, Emitter<SearchState> emit) async {
    final result = await searchShows(SearchShowsParams(
      query: 'Dark',
    ));
    result.fold(
      (failure) => emit(SearchFailure(failure)),
      (shows) => emit(SearchEmpty(shows)),
    );
  }

  void _onPerformSearch(
      PerformNameSearch event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    final result = await searchShows(SearchShowsParams(
      query: event.query.trim(),
    ));
    result.fold(
      (failure) => emit(SearchFailure(failure)),
      (shows) => emit(SearchSuccess(shows)),
    );
  }
}
