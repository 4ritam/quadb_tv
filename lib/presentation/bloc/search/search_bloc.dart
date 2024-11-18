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
    on<PerformSearch>(_onPerformSearch);
  }

  void _onPerformSearch(PerformSearch event, Emitter<SearchState> emit) async {
    if (event.query.isEmpty) {
      emit(SearchInitial());
    } else {
      emit(SearchLoading());
      final result = await searchShows(SearchShowsParams(query: event.query));
      emit(result.fold(
        (failure) => SearchFailure(failure),
        (shows) => SearchSuccess(shows),
      ));
    }
  }
}
