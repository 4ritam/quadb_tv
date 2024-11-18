import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:quadb_tv/core/errors/failures.dart';
import 'package:quadb_tv/domain/entities/show.dart';

import '../../../domain/usecases/get_all_shows.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllShows getAllShows;

  HomeBloc({required this.getAllShows}) : super(const HomeInitial()) {
    on<LoadShows>(_onLoadShows);
  }

  void _onLoadShows(
    LoadShows event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    final result = await getAllShows();

    result.fold(
      (failure) => emit(HomeFailure(failure)),
      (shows) => emit(HomeSuccess(shows)),
    );
  }
}
